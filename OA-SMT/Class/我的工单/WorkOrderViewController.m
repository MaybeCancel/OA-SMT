//
//  WorkOrderViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/8/23.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "WorkOrderViewController.h"
#import "WorkOrderCell.h"
#import "WorkOrderModel.h"
#import "GoodReportViewController.h"
#import "WarningDetailViewController.h"
#import "InstallTestViewController.h"
#import "QualityDetailViewController.h"
#import "OtherDetailViewController.h"

@interface WorkOrderViewController ()

@end

@implementation WorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的工单";
    
    [self loadData];
} 

- (void)loadData{
    kWeakSelf(weakSelf);
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[UserDef objectForKey:@"phone"] forKey:@"accountName"];
    [param setObject:@"0" forKey:@"currentPage"];
    [param setObject:@"10" forKey:@"pageSize"];
    [param setObject:@"" forKey:@"workOrderTypeId"];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetWorkOrderList] isPost:YES Params:param];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* array = jsonDic[@"result"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary* dic in array) {
            WorkOrderModel* model = [WorkOrderModel ModelWithDic:dic];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkOrderCell* cell = [WorkOrderCell cellWithTableView:tableView];
    WorkOrderModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WorkOrderModel *model = self.dataArray[indexPath.row];
    kWeakSelf(weakSelf);
    switch (model.workOrderTypeId) {
        case 1://收货验货（完成）
        {
            GoodReportViewController* report = [[GoodReportViewController alloc]init];
            report.refreshBlock = ^{
                [weakSelf loadData];
            };
            report.model = model;
            [self pushVC:report];
        }
            break;
        case 2://安装施工
        {
            InstallTestViewController *installTestVC = [[InstallTestViewController alloc]init];
            installTestVC.model = model;
            [self pushVC:installTestVC];
        }
            break;
        case 3://告警处理（完成）
        {
            WarningDetailViewController* detailVC = [[WarningDetailViewController alloc]init];
            detailVC.refreshBlock = ^{
                [weakSelf loadData];
            };
            detailVC.model = model;
            [self pushVC:detailVC];
        }
            break;
        case 4://整改闭环（完成）
        {
            QualityDetailViewController* detailVC = [[QualityDetailViewController alloc]init];
            detailVC.refreshBlock = ^{
                [weakSelf loadData];
            };
            detailVC.model = model;
            [self pushVC:detailVC];
        }
            break;
        case 5://其他工单类型（完成）
        {
            OtherDetailViewController* detailVC = [[OtherDetailViewController alloc]init];
            detailVC.refreshBlock = ^{
                [weakSelf loadData];
            };
            detailVC.model = model;
            [self pushVC:detailVC];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
