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
@property (nonatomic,strong)UITableView* tableView;

@end;

@implementation OpenBoxReporyView{
    UIView* _topView;
    UILabel* _topTitle;
}
- (void)setHeaderString:(NSString *)headerString{
    _headerString = headerString;
    _topTitle.text = _headerString;
}
- (void)setTitles:(NSMutableArray *)titles{
    _titles = titles;
    [self initUI];
}
- (void)setTopTextViewTitle:(NSString *)topTextViewTitle{
    _topTextViewTitle = topTextViewTitle;
    [self.tableView reloadData];
}
- (void)setTextPlaceHolder:(NSString *)textPlaceHolder{
    _textPlaceHolder = textPlaceHolder;
    [self.tableView reloadData];
}
- (void)setArrowHidden:(BOOL)arrowHidden{
    _arrowHidden = arrowHidden;
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
    [self addSubview:self.tableView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _topView.frame = RR(0, 0, ScreenWidth, 44);
    _topTitle.frame = RR(15, 15, 200, 15);
    _tableView.frame = RR(0, CGRectGetMaxY(_topView.frame), ScreenWidth, 44* self.titles.count +130);
}

#pragma mark tableView - delegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.titles.count  == indexPath.row ) {
        TextViewCell* cell = [TextViewCell nibCellWithTableView:tableView];
        cell.topTitleLabel.text = self.topTextViewTitle;
        cell.placeHolder = self.textPlaceHolder;
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        return cell;
    }else{
        BaseCell* cell = [BaseCell nibCellWithTableView:tableView];
        cell.leftString.text = self.titles[indexPath.row];
        cell.arrowHidden = self.arrowHidden;
        return cell;
    }
}

#pragma mark tableView - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.titles.count) {
        return 130;
    }else{
        return 44;
    }
}

@end
