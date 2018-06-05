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
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _headView.frame = CGRM(0, 0, SCREEN_WIDTH, 44);
    _topTitle.frame = CGRM(12, 12, 180, 20);
    _foldImage.frame = CGRM(SCREEN_WIDTH - 15 -12 , 18, 12, 7);
    _topLine.frame = CGRM(0, 43, SCREEN_WIDTH, 1);
    kWeakSelf(weakSelf);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headView.mas_bottom);
        make.left.mas_equalTo(weakSelf.mas_left);
        make.right.mas_equalTo(weakSelf.mas_right);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
    }];
}


- (void)initUI{
    __weak typeof(FoldListView*)weakSel = self;
    _headView = [[UIView alloc]init];
    [self addSubview:_headView];
    [_headView addTapActionWithBlock:^{
        weakSel.isFold = !weakSel.isFold;
        [weakSel roatAnimationWithView:weakSel.foldImage];
        CGFloat diffHeight = self.leftArray.count*44;
        weakSel.height = weakSel.height + (weakSel.isFold ? -diffHeight : diffHeight);
        if (weakSel.foldActionBlock) {
            weakSel.foldActionBlock(weakSel.isFold ? -diffHeight : diffHeight);
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

-(void)setRightArray:(NSArray *)rightArray{
    _rightArray = rightArray;
    [self.tableView reloadData];
}

//旋转图片
- (void)roatAnimationWithView:(UIView*)view{
    view.transform = CGAffineTransformRotate(view.transform, M_PI);//旋转180
}

#pragma mark tableView - delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark tableView - dataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellPe* cell = [BaseCellPe nibCellWithTableView:tableView];
    if (self.leftArray) {
        cell.leftLabel.text = self.leftArray[indexPath.row];
    }
    if (self.rightArray&&self.rightArray.count == self.leftArray.count) {
        cell.rightLabel.text = self.rightArray[indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftArray.count;
}

@end
