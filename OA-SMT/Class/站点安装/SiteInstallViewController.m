//
//  SiteInstallViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SiteInstallViewController.h"
#import "SiteInstallDetailViewController.h"
#import "InstallSiteModel.h"
#import "SiteInstallCell.h"

@interface SiteInstallViewController ()

@end

@implementation SiteInstallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"站点安装";
    [self loadData];
}

- (void)loadData{
    kWeakSelf(weakSelf);
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:InstallInfoList] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* array = jsonDic[@"result"];
        for (NSDictionary* dic in array) {
            InstallSiteModel* model = [InstallSiteModel ModelWithDic:dic];
            [self.dataArray addObject:model];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf(weakSelf);
    SiteInstallDetailViewController *detailVC = [[SiteInstallDetailViewController alloc]init];
    detailVC.refreshBlock = ^{
        [weakSelf loadData];
    };
    detailVC.model = self.dataArray[indexPath.row];
    [self pushVC:detailVC];
}

@end
