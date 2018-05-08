//
//  StateInstallViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "StateInstallViewController.h"

@interface StateInstallViewController ()

@end

@implementation StateInstallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"站点安装";
    [self loadData];
    
}
- (void)loadData{
    self.dataArray = [NSMutableArray new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
