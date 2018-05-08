//
//  OpenBoxViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "OpenBoxViewController.h"
#import "GoodsCell.h"
#import "GoodListModel.h"
#import "ReceiveGoodReportViewController.h"
@interface OpenBoxViewController ()

@end

@implementation OpenBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开箱验货";
    [self loadData];
    
    
    self.tableView = [[BaseTableView alloc]initWithFrame:RR(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBColor(241, 241, 241);
    [self.view addSubview:self.tableView];
}
- (void)loadData{
    self.dataArray = [NSMutableArray new];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:@"/project/checkoutGoodsList"] isPost:YES Params:@{@"userId":[Default objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* goods = jsonDic[@"result"];
        for (NSDictionary* dic in goods) {
            GoodListModel* model = [GoodListModel ModelWithDic:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    //return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 178+15;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell* cell = [GoodsCell nibCellWithTableView:tableView];
//    GoodListModel* model = self.dataArray[indexPath.row];
//    [cell loadDataFromModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReceiveGoodReportViewController* report = [[ReceiveGoodReportViewController alloc]init];
    report.headTitle = @"开箱报告";
    report.boxTitle = @"开箱时间";
    [self pushVC:report];
}
@end
