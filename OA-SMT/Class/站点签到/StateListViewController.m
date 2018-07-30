//
//  StateListViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "StateListViewController.h"
#import "StateListCell.h"
@interface StateListViewController ()
@end
@implementation StateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"站名列表";
    [self setUp];
    [self loadData];
}
- (void)loadData{
    [LoadingView showProgressHUD:@""];
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:StationsList] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* array = jsonDic[@"result"];
        for (NSDictionary* dic in array) {
            StateModel* model = [StateModel ModelWithDic:dic];
            [self.dataArray addObject:model];
            [self.tableView reloadData];
        }
    }];
}
- (void)setUp{
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StateListCell* cell = [StateListCell nibCellWithTableView:tableView];
    StateModel* model = self.dataArray[indexPath.row];
    cell.titleLab.text = model.stationName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StateModel* model = self.dataArray[indexPath.row];
    if (self.stateInfoHandle) {
        self.stateInfoHandle(model);
    }
    [self pop];
}

@end
