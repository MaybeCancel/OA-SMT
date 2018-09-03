//
//  BackLogViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/13.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BackLogViewController.h"
#import "BackLogListModel.h"
#import "WarningCell.h"
#import "GoodsCell.h"
#import "SiteInstallCell.h"
#import "GoodReportViewController.h"
#import "WarningDetailViewController.h"
#import "SiteTestDetailViewController.h"
#import "SiteInstallDetailViewController.h"

@interface BackLogViewController ()

@end

@implementation BackLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待办事项";
    [self setupUI];
    [self loadData];
}

-(void)setupUI{
    self.tableView = [[BaseTableView alloc]init];
    self.tableView.frame = CGRM(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64-15);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBColor(237, 237, 237);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)loadData{
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetSchedule] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* result = jsonDic[@"result"];
        [self.dataArray removeAllObjects];
        if ([result isKindOfClass:[NSArray class]]) {
            for (NSDictionary* dic in result) {
                BackLogListModel* model = [BackLogListModel ModelWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    }];
}


#pragma mark -- UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BackLogListModel *model = self.dataArray[indexPath.row];
    if (model.type == 1) {
        GoodsCell *cell = [GoodsCell nibCellWithTableView:tableView];
        [cell setModelData:model.logisticsInfo isReceive:YES];
        return cell;
    }
    else if (model.type == 2){
        GoodsCell *cell = [GoodsCell nibCellWithTableView:tableView];
        [cell setModelData:model.logisticsInfo isReceive:NO];
        return cell;
    }
    else if (model.type == 3){
        WarningCell *cell = [WarningCell nibCellWithTableView:tableView];
        cell.model = model.alarmList;
        return cell;
    }
    else if (model.type == 4){
        SiteInstallCell *cell = [SiteInstallCell nibCellWithTableView:tableView];
        cell.model = model.installInfo;
        return cell;
    }
    else{
        SiteInstallCell *cell = [SiteInstallCell nibCellWithTableView:tableView];
        cell.model = model.installInfo;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf(weakSelf);
//    BackLogListModel* model = self.dataArray[indexPath.row];
//    if (model.type == 1) {
//        GoodReportViewController* report = [[GoodReportViewController alloc]init];
//        report.refreshBlock = ^{
//            [weakSelf loadData];
//        };
//        report.isReceive = YES;
//        report.status = model.logisticsInfo.status;
//        report.goodsId = model.logisticsInfo.goodsId;
//        [self pushVC:report];
//    }
//    else if (model.type == 2){
//        GoodReportViewController* report = [[GoodReportViewController alloc]init];
//        report.refreshBlock = ^{
//            [weakSelf loadData];
//        };
//        report.isReceive = NO;
//        report.status = model.logisticsInfo.status;
//        report.goodsId = model.logisticsInfo.goodsId;
//        [self pushVC:report];
//    }
//    else if (model.type == 3){
//        WarningDetailViewController* detail = [[WarningDetailViewController alloc]init];
//        detail.refreshBlock = ^{
//            [weakSelf loadData];
//        };
//        detail.alarmId = model.alarmList.alarmId;
//        [self pushVC:detail];
//    }
//    else if (model.type == 4){
//        SiteInstallDetailViewController *detailVC = [[SiteInstallDetailViewController alloc]init];
//        detailVC.model = model.installInfo;
//        detailVC.refreshBlock = ^{
//            [weakSelf loadData];
//        };
//        [self pushVC:detailVC];
//    }
//    else if (model.type == 5){
//        SiteTestDetailViewController* detailVC = [[SiteTestDetailViewController alloc]init];
//        detailVC.model = model.installInfo;
//        detailVC.refreshBlock = ^{
//            [weakSelf loadData];
//        };
//        [self pushVC:detailVC];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BackLogListModel *model = self.dataArray[indexPath.row];
    if (model.type == 3) {
        return 125+15;
    }
    else{
        return 178+15;
        
    }
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
