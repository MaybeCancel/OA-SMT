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

@interface InstallTestViewController (){
    BOOL _isRefresh;
}
@property (nonatomic, strong) InstallTestView *cell;
@end

@implementation InstallTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)setupUI{
    self.title = @"我的工单-安装施工";
    
    self.cell = [[InstallTestView alloc]initWithFrame:CGRM(0, 64, SCREEN_WIDTH, 280)];
    self.cell.model = self.model;
    [self.view addSubview:self.cell];
}

- (IBAction)toCompletePicVC:(id)sender {
    kWeakSelf(weakSelf);
    CompletePicViewController *VC = [[CompletePicViewController alloc]init];
    VC.model = self.model;
    VC.refreshBlock = ^{
        _isRefresh = YES;
        weakSelf.model.status = @1;
        weakSelf.cell.model = weakSelf.model;
    };
    [self pushVC:VC];
}

- (IBAction)toInstallReportVC:(id)sender {
    kWeakSelf(weakSelf);
    SiteInstallDetailViewController *detailVC = [[SiteInstallDetailViewController alloc]init];
    detailVC.model = self.model;
    detailVC.refreshBlock = ^{
        _isRefresh = YES;
        weakSelf.model.status = @1;
        weakSelf.cell.model = weakSelf.model;
    };
    [self pushVC:detailVC];
}

- (IBAction)toTestReportVC:(id)sender {
    kWeakSelf(weakSelf);
    SiteTestDetailViewController *detailVC = [[SiteTestDetailViewController alloc]init];
    detailVC.model = self.model;
    detailVC.refreshBlock = ^{
        _isRefresh = YES;
        weakSelf.model.status = @1;
        weakSelf.cell.model = weakSelf.model;
    };
    [self pushVC:detailVC];
}

-(void)pop{
    if (_isRefresh && self.refreshBlock) {
        self.refreshBlock();
    }
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
