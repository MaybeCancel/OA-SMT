//
//  DealWarningViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "DealWarningViewController.h"
#import "WarningCell.h"
#import "WarningDetailViewController.h"
@interface DealWarningViewController ()

@end

@implementation DealWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[BaseTableView alloc]init];
    self.tableView.frame = RR(0, 64 + 15, ScreenWidth, ScreenHeight - 64-15);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBColor(237, 237, 237);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"告警排除";
    [self.view addSubview:self.tableView];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WarningCell* cell = [WarningCell nibCellWithTableView:tableView];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WarningDetailViewController* detail = [[WarningDetailViewController alloc]init];
    [self pushVC:detail];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125 + 15;
}
@end
