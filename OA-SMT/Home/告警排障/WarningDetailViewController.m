//
//  WarningDetailViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "WarningDetailViewController.h"
#import "BaseCellPe.h"
#import "FoldListView.h"
#import "BaseListImageView.h"
#import "OpenBoxReporyView.h"
@interface WarningDetailViewController ()
@property (nonatomic,strong)UIScrollView* scrollView;
@property (nonatomic,strong)FoldListView* list;
@property (nonatomic,strong)NSArray* leftArray;
@property (nonatomic,strong)BaseListImageView* listImageView;
@property (nonatomic,strong)OpenBoxReporyView* box;


@end

@implementation WarningDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"告警处理报告";
    self.rightItemTitle = @"提交";
    self.rightItemHandle = ^{
        NSLog(@"提交");
    };
    [self setUp];
}
- (void)setUp{
    self.leftArray = @[@"施工优先级",@"创建人",@"问题日期",@"项目",@"问题描述"];
    self.list.leftArray = self.leftArray;
    [self.scrollView addSubview:self.list];
   
    
    NSMutableArray* images =[NSMutableArray arrayWithObjects:@"tou.jpg",@"gouza",@"weiketuo",@"zhaungbei.jpg", nil];
    self.listImageView.images = images;
    self.listImageView.frame = RR(0, CGRectGetMaxY(self.list.frame), ScreenWidth, 75 +( 230+15) * images.count);
    self.listImageView.topString = @"附件";
    self.listImageView.btnTitle = @"Excel";
     self.scrollView.contentSize = CGSizeMake(0, self.list.height + self.listImageView.height+64);
    
    
}
- (UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:RR(0, 64, ScreenWidth, ScreenHeight - 64)];
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = RGBColor(237, 237, 237);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (FoldListView*)list{
    if (_list == nil) {
        _list = [[FoldListView alloc]init];
        _list.frame = RR(0, 0, ScreenWidth, 44 + self.leftArray.count* 44);
        _list.topTitleString = @"告警安排详情";
    }
    return _list;
}

- (BaseListImageView*)listImageView{
    if (!_listImageView) {
        _listImageView = [[BaseListImageView alloc]init];
       
        [_scrollView addSubview:_listImageView];
    }
    return _listImageView;
}
//- (OpenBoxReporyView*)box{
//    if (!_box) {
//        _box = [[OpenBoxReporyView alloc]init];
//        _box.reportState = 1;
//    }
//    return _box;
//}


#pragma mark tableView - delegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellPe* cell = [BaseCellPe nibCellWithTableView:tableView];
 //   cell.leftLabel.text = self.leftArray[indexPath.row];
    cell.rightLabel.text = @"666";//self.dataArray[indexPath.row];
    return cell;
}

#pragma mark tableView - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

@end
