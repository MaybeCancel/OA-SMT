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
#import "SiteInstallDetailViewController.h"
#import "InstallTestView.h"

@interface InstallTestViewController ()

@end

@implementation InstallTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupUI{
    InstallTestView *cell = [[InstallTestView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, 280)];
    cell.model = self.model;
    [self.view addSubview:cell];
}

- (IBAction)toCompletePicVC:(id)sender {
    CompletePicViewController *VC = [[CompletePicViewController alloc]init];
    [self pushVC:VC];
}

- (IBAction)toInstallReportVC:(id)sender {
    SiteInstallDetailViewController *detailVC = [[SiteInstallDetailViewController alloc]init];
    detailVC.model = self.model;
    detailVC.refreshBlock = ^{
//        [weakSelf loadData];
    };
    [self pushVC:detailVC];
}

- (IBAction)toTestReportVC:(id)sender {
    SiteTestDetailViewController *detailVC = [[SiteTestDetailViewController alloc]init];
    detailVC.model = self.model;
    detailVC.refreshBlock = ^{
//        [weakSelf loadData];
    };
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
