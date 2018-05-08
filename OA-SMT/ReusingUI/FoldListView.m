//
//  FoldListView.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "FoldListView.h"
#import "BaseCellPe.h"
@class FoldListView;
@interface FoldListView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)BaseTableView* tableView;
@property (nonatomic,strong)UIImageView* foldImage;
@property (nonatomic,assign)BOOL isFold;
@end
@implementation FoldListView{
    UILabel* _topTitle;
    UIView* _headView;
    UIView* _topLine;
    BOOL _isFold;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _headView.frame = RR(0, 0, ScreenWidth, 44);
    _topTitle.frame = RR(12, 12, 180, 20);
    _foldImage.frame = RR(ScreenWidth - 15 -12 , 18, 12, 7);
    _topLine.frame = RR(0, 43, ScreenWidth, 1);
    if (!self.isFold) {
          _tableView.frame = RR(0, CGRectGetMaxY(_headView.frame), ScreenWidth, self.leftArray.count * 44);
    }
}


- (void)initUI{
    __weak typeof(FoldListView*)weakSel = self;
    _headView = [[UIView alloc]init];
    [self addSubview:_headView];
    [_headView addTapActionWithBlock:^{
        weakSel.isFold = !weakSel.isFold;
        [weakSel roatAnimationWithView:weakSel.foldImage];
        if (weakSel.isFold) {
            [UIView animateWithDuration:0.3 animations:^{
                weakSel.tableView.height = 0;
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                weakSel.tableView.height = self.leftArray.count*44;
            }];
        }
    }];

    _topTitle = [[UILabel alloc]init];
    [_headView addSubview:_topTitle];
    
    _foldImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_listU"]];
    [_headView addSubview:_foldImage];
 
    _topLine = [[UIView alloc]init];
    _topLine.backgroundColor = RGBColor(231, 231, 231);
    [_headView addSubview:_topLine];

    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
}

//set
- (void)setTopTitleString:(NSString *)topTitleString{
    _topTitleString = topTitleString;
    _topTitle.text = _topTitleString;
}
- (void)setLeftArray:(NSArray *)leftArray{
    _leftArray = leftArray;
    [self.tableView reloadData];
}

//旋转图片
- (void)roatAnimationWithView:(UIView*)view{
    view.transform = CGAffineTransformRotate(view.transform, M_PI);//旋转180
}

#pragma mark tableView - delegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellPe* cell = [BaseCellPe nibCellWithTableView:tableView];
    if (self.leftArray) {
        cell.leftLabel.text = self.leftArray[indexPath.row];
    }
    if (self.righArray&&self.righArray.count == self.leftArray.count) {
        cell.leftLabel.text = self.righArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark tableView - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftArray.count;
}

@end
