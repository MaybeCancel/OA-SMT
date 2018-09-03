//
//  DealWarningViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "DealWarningViewController.h"
#import "WarningCell.h"
#import "WarningListModel.h"
#import "WarningDetailViewController.h"
@interface DealWarningViewController ()

@end

@implementation DealWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"告警排除";
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
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:AlarmList] isPost:YES Params:@{@"userId":[UserDef objectForKey:@"userId"]}];
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSArray* result = jsonDic[@"result"];
        [self.dataArray removeAllObjects];
        if ([result isKindOfClass:[NSArray class]]) {
            for (NSDictionary* dic in result) {
                WarningListModel* model = [WarningListModel ModelWithDic:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark -- UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WarningCell* cell = [WarningCell nibCellWithTableView:tableView];
    WarningListModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf(weakSelf);
    WarningListModel *model = self.dataArray[indexPath.row];
    WarningDetailViewController* detail = [[WarningDetailViewController alloc]init];
    detail.refreshBlock = ^{
        [weakSelf loadData];
    };
    [self pushVC:detail];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125+15;
}


@end
