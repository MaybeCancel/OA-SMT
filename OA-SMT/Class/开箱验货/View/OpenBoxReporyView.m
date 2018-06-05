//
//  OpenBoxReporyView.m
//  OA-SMT
//
//  Created by Slark on 2018/2/28.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "OpenBoxReporyView.h"
#import "BaseCell.h"
#import "TextViewCell.h"
@class OpenBoxReporyView;

@interface OpenBoxReporyView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end;

@implementation OpenBoxReporyView{
    UIView* _topView;
    UILabel* _topTitle;
}
- (void)setHeaderString:(NSString *)headerString{
    _headerString = headerString;
    _topTitle.text = _headerString;
}
- (void)setLeftTitles:(NSMutableArray *)leftTitles{
    _leftTitles = leftTitles;
    [self initUI];
}
-(void)setFirstText:(NSString *)firstText{
    _firstText = firstText;
    [self.tableView reloadData];
}
-(void)setSecondText:(NSString *)secondText{
    _secondText = secondText;
    [self.tableView reloadData];
}
-(void)setNoteText:(NSString *)noteText{
    _noteText = noteText;
    [self.tableView reloadData];
}
- (void)setTopTextViewTitle:(NSString *)topTextViewTitle{
    _topTextViewTitle = topTextViewTitle;
    [self.tableView reloadData];
}
- (void)setTextPlaceHolder:(NSString *)textPlaceHolder{
    _textPlaceHolder = textPlaceHolder;
    [self.tableView reloadData];
}

- (void)initUI{
    _topView = [[UIView alloc]init];
    [self addSubview:_topView];
    _topTitle = [[UILabel alloc]init];
    _topTitle.textColor = RGBColor(132, 132, 132);
    _topTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_topTitle];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    [self addSubview:self.tableView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _topView.frame = CGRM(0, 0, SCREEN_WIDTH, 44);
    _topTitle.frame = CGRM(15, 15, 200, 15);
    _tableView.frame = CGRM(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, 44* self.leftTitles.count +130);
}

#pragma mark tableView - delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        if (self.firstClickBlock) {
            self.firstClickBlock();
        }
    }
    else if (indexPath.row == 1){
        if (self.secondClickBlock) {
            self.secondClickBlock();
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.leftTitles.count) {
        return 130;
    }else{
        return 44;
    }
}

#pragma mark tableView - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftTitles.count + 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.leftTitles.count  == indexPath.row ) {
        TextViewCell* cell = [TextViewCell nibCellWithTableView:tableView];
        cell.topTitleLabel.text = self.topTextViewTitle;
        cell.placeHolder = self.textPlaceHolder;
        kWeakSelf(weakSelf);
        cell.optNoteBlock = ^(NSString *note) {
            weakSelf.noteText = note;
        };
        if (self.noteText && self.noteText.length) {
            cell.textView.text = self.noteText;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        BaseCell* cell = [BaseCell nibCellWithTableView:tableView];
        cell.leftString.text = self.leftTitles[indexPath.row];
        if (indexPath.row == 0) {
            cell.rightString.text = self.firstText;
        }
        else if (indexPath.row == 1){
            cell.rightString.text = [self.secondText isEqualToString:@"0"] ? @"否" : @"是";
        }
        cell.arrowHidden = YES;
        return cell;
    }
}


@end
