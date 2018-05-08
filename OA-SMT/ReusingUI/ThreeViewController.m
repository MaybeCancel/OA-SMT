//
//  ThreeViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ThreeViewController.h"
#import "StateInstallCell.h"
@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[BaseTableView alloc]initWithFrame:RR(0, 64+15, ScreenWidth, ScreenHeight - 64 - 15) style:UITableViewStylePlain];
    self.tableView.backgroundColor = RGBColor(237, 237, 237);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StateInstallCell* cell = [StateInstallCell nibCellWithTableView:tableView];
    cell.backgroundColor = [UIColor redColor];
    cell.titleLabel.text = @"123";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150+15;
}
@end
