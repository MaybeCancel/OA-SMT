//
//  MainViewController.m
//  OA-SMT
//
//  Created by Slark on 2017/12/27.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "MainViewController.h"
#import "HomeUIView.h"
#import "CompletePicViewController.h"
#import "ReceiveListViewController.h"
#import "OpenBoxViewController.h"
#import "SignViewController.h"
#import "ObjectInfoViewController.h"
#import "BackLogViewController.h"
#import "CloseLoopViewController.h"
#import "StateTestViewController.h"
#import "StateInstallViewController.h"
#import "DealWarningViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:151.0/255.0 blue:252/255.0 alpha:1];
    self.barColor =RGBColor(75, 151, 252);
    self.title = @"爱立信站点辅助管理系统";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeUIView* homeView = [[HomeUIView alloc]initWithTitles:@[@"工程信息",@"待办事项",@"收获验货",@"开箱验货",@"站点签到",@"站点安装",@"站点调测",@"告警排障",@"整改闭环",@"完工照片",@"变动申请",@"关于工具"] AndImages:@[@"btn_home_01",@"btn_home_02",@"btn_home_03",@"btn_home_04",@"btn_home_05",@"btn_home_06",@"btn_home_07",@"btn_home_08",@"btn_home_09",@"btn_home_10",@"btn_home_11",@"btn_home_12"]];
    homeView.frame = RR(12, 64, self.view.width - 24, self.view.height - 60);
    homeView.acounceTitle = @"发现新版本,请火速更新~~~";
    [self.view addSubview:homeView];
    
    homeView.pageViewHandle = ^(NSInteger tag){
        UIViewController* VC = nil;
        self.Hidden_BackTile = YES;
        switch (tag) {
            case 10:
                VC = [[ObjectInfoViewController alloc]init];
                [self pushVC:VC];
                break;
            case 11:
                VC = [[BackLogViewController alloc]init];
                [self pushVC:VC];
                NSLog(@"待办事项");
                break;
            case 12:
                VC = [[ReceiveListViewController alloc]init];
                [self pushVC:VC];
                break;
            case 13:
                VC = [[OpenBoxViewController alloc]init];
                [self pushVC:VC];
                break;
            case 14:
                VC = [[SignViewController alloc]init];
                [self pushVC:VC];
                break;
            case 15:
                VC = [[StateInstallViewController alloc]init];
                [self pushVC:VC];
                NSLog(@"站点安装");
                break;
            case 16:
                VC = [[StateInstallViewController alloc]init];
                [self pushVC:VC];
                NSLog(@"站点调测");
                break;
            case 17:
                VC = [[DealWarningViewController alloc]init];
                [self pushVC:VC];
                NSLog(@"告警排障");
                break;
            case 18:
                VC = [[CloseLoopViewController alloc]init];
                [self pushVC:VC];
                NSLog(@"整改闭环");
                break;
            case 19:
                VC = [[CompletePicViewController alloc]init];
                [self pushVC:VC];
                break;
            case 20:
                NSLog(@"变动申请");
                break;
            case 21:
                NSLog(@"关于工具");
                break;
                
            default:
                break;
        }
    };
}
@end
