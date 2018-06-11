//
//  SignRecodViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/22.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SignRecodViewController.h"
#import "signCell.h"
#import "StateModel.h"
#import "SignRecodeModel.h"
@interface SignRecodViewController ()

@end

@implementation SignRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到记录";
    [self loadData];
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)loadData{
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:SignInLog] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* result = jsonDic[@"result"];
        if ([result isKindOfClass:[NSArray class]]) {
            for (NSDictionary*dic in result) {
                SignRecodeModel* model = [SignRecodeModel ModelWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    signCell* cell = [signCell nibCellWithTableView:tableView];
    cell.userInteractionEnabled = NO;
    SignRecodeModel* model = self.dataArray[indexPath.row];
    [cell loadDataFromModel:model];
    return cell;
}

@end
