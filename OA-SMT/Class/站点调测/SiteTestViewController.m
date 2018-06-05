//
//  SiteTestViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SiteTestViewController.h"
#import "SiteTestDetailViewController.h"
#import "InstallSiteModel.h"
#import "SiteInstallCell.h"

@interface SiteTestViewController ()

@end

@implementation SiteTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"站点调测";
    [self loadData];
}

- (void)loadData{
    kWeakSelf(weakSelf);
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:TestInfoList] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* array = jsonDic[@"result"];
        for (NSDictionary* dic in array) {
            InstallSiteModel* model = [InstallSiteModel ModelWithDic:dic];
            [self.dataArray addObject:model];
        }
        if (array.count == 0) {
            [LoadingView showAlertHUD:@"暂无测试数据" duration:1.0];
        }
        [weakSelf.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SiteInstallCell* cell = [SiteInstallCell nibCellWithTableView:tableView];
    InstallSiteModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf(weakSelf);
    SiteTestDetailViewController *detailVC = [[SiteTestDetailViewController alloc]init];
    detailVC.refreshBlock = ^{
        [weakSelf loadData];
    };
    detailVC.model = self.dataArray[indexPath.row];
    [self pushVC:detailVC];
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
