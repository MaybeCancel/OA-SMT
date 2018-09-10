//
//  CloseLoopViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "CloseLoopViewController.h"
#import "QualityCell.h"
#import "QualityModel.h"
#import "QualityDetailViewController.h"

@interface CloseLoopViewController ()

@end

@implementation CloseLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"整改闭环";
    [self loadData];
}

-(void)loadData{
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:RectificationList] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* result = jsonDic[@"result"];
        [self.dataArray removeAllObjects];
        if ([result isKindOfClass:[NSArray class]]) {
            for (NSDictionary* dic in result) {
                QualityModel* model = [QualityModel ModelWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QualityCell *cell = [QualityCell nibCellWithTableView:tableView];
    QualityModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf(weakSelf);
    QualityModel *model = self.dataArray[indexPath.row];
    QualityDetailViewController *detailVC = [[QualityDetailViewController alloc]init];
    detailVC.refreshBlock = ^{
        [weakSelf loadData];
    };
    [self pushVC:detailVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
