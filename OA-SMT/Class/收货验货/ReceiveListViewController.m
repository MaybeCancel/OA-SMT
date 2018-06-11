//
//  ReceiveListViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ReceiveListViewController.h"
#import "GoodsCell.h"
#import "GoodListModel.h"
#import "GoodReportViewController.h"
@interface ReceiveListViewController ()

@end

@implementation ReceiveListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"收货验货";
    [self loadData];
    
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBColor(241, 241, 241);
    [self.view addSubview:self.tableView];
}
- (void)loadData{
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:ReceiveGoodsList] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        if ([jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            NSArray* goods = jsonDic[@"result"];
            [self.dataArray removeAllObjects];
            if ([goods isKindOfClass:[NSArray class]]) {
                for (NSDictionary* dic in goods) {
                    GoodListModel* model = [GoodListModel ModelWithDic:dic];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
            }
        }
        else{
            [LoadingView showAlertHUD:jsonDic[@"message"] duration:1.0];
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 178+15;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell* cell = [GoodsCell nibCellWithTableView:tableView];
    GoodListModel* model = self.dataArray[indexPath.row];
    [cell setModelData:model isReceive:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf(weakSelf);
    GoodListModel* model = self.dataArray[indexPath.row];
    GoodReportViewController* report = [[GoodReportViewController alloc]init];
    report.refreshBlock = ^{
        [weakSelf loadData];
    };
    report.boxTitle = @"实际到达日期";
    report.headTitle = @"收货报告";
    report.isReceive = YES;
    report.status = model.status;
    report.goodsId = model.goodsId;
    [self pushVC:report];
}

@end
