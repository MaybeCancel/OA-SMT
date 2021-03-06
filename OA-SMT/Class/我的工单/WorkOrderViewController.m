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
{
    int _currentPage;
    int _size;
}

@end

@implementation WorkOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的工单";
    
    [self setupUI];
    [self refreshHeaderData];
}

-(void)setupUI{
    //上拉加载多次调用的bug
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    MJRefreshNormalHeader * nomalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderData)];
    //设置刷新提示语句
    [nomalHeader setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
    //设置字体和文字
    nomalHeader.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = nomalHeader;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooterData)];
    [footer setTitle:@"没有更多了" forState:(MJRefreshStateNoMoreData)];
    // 设置文字
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
}

-(void)refreshHeaderData{
    kWeakSelf(weakSelf);
    _currentPage = 0;
    _size = 0;
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[UserDef objectForKey:@"phone"] forKey:@"accountName"];
    [param setObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"currentPage"];
    [param setObject:@"10" forKey:@"pageSize"];
    [param setObject:@"" forKey:@"workOrderTypeId"];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetWorkOrderList] isPost:YES Params:param];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        [weakSelf.tableView.mj_header endRefreshing];
        if ([jsonDic[@"resultCode"] respondsToSelector:@selector(isEqualToString:)] && [jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            _size = [jsonDic[@"size"] intValue];
            NSArray* array = jsonDic[@"result"];
            [weakSelf.dataArray removeAllObjects];
            for (NSDictionary* dic in array) {
                WorkOrderModel* model = [WorkOrderModel ModelWithDic:dic];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
    }];
}

-(void)refreshFooterData{
    if (self.dataArray.count == _size) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    kWeakSelf(weakSelf);
    _currentPage++;
    [LoadingView showProgressHUD:@""];
    NSMutableDictionary *param = [NSMutableDictionary new];
    [param setObject:[UserDef objectForKey:@"phone"] forKey:@"accountName"];
    [param setObject:[NSString stringWithFormat:@"%d",_currentPage] forKey:@"currentPage"];
    [param setObject:@"10" forKey:@"pageSize"];
    [param setObject:@"" forKey:@"workOrderTypeId"];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetWorkOrderList] isPost:YES Params:param];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        [weakSelf.tableView.mj_footer endRefreshing];
        if ([jsonDic[@"resultCode"] respondsToSelector:@selector(isEqualToString:)] && [jsonDic[@"resultCode"] isEqualToString:@"100"]) {
            NSArray* array = jsonDic[@"result"];
            for (NSDictionary* dic in array) {
                WorkOrderModel* model = [WorkOrderModel ModelWithDic:dic];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
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
                [weakSelf refreshHeaderData];
            };
            report.model = model;
            [self pushVC:report];
        }
            break;
        case 2://安装施工
        {
            InstallTestViewController *installTestVC = [[InstallTestViewController alloc]init];
            installTestVC.model = model;
            installTestVC.refreshBlock = ^{
                [weakSelf refreshHeaderData];
            };
            [self pushVC:installTestVC];
        }
            break;
        case 3://告警处理（完成）
        {
            WarningDetailViewController* detailVC = [[WarningDetailViewController alloc]init];
            detailVC.refreshBlock = ^{
                [weakSelf refreshHeaderData];
            };
            detailVC.model = model;
            [self pushVC:detailVC];
        }
            break;
        case 4://整改闭环（完成）
        {
            QualityDetailViewController* detailVC = [[QualityDetailViewController alloc]init];
            detailVC.refreshBlock = ^{
                [weakSelf refreshHeaderData];
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
    return 310;
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
