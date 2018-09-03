//
//  InstallTestViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/8/30.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "InstallTestViewController.h"
#import "CompletePicViewController.h"
#import "SiteTestDetailViewController.h"

@interface InstallTestViewController ()

@end

@implementation InstallTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)toCompletePicVC:(id)sender {
    CompletePicViewController *VC = [[CompletePicViewController alloc]init];
    [self pushVC:VC];
}

- (IBAction)toInstallReportVC:(id)sender {
    SiteTestDetailViewController *detailVC = [[SiteTestDetailViewController alloc]init];
    detailVC.refreshBlock = ^{
//        [weakSelf loadData];
    };
//    detailVC.model = self.dataArray[indexPath.row];
    [self pushVC:detailVC];
}

- (IBAction)toTestReportVC:(id)sender {
    SiteTestDetailViewController *detailVC = [[SiteTestDetailViewController alloc]init];
    detailVC.refreshBlock = ^{
//        [weakSelf loadData];
    };
//    detailVC.model = self.dataArray[indexPath.row];
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
