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
#import "ProjectInfoViewController.h"
#import "BackLogViewController.h"
#import "CloseLoopViewController.h"
#import "SiteTestViewController.h"
#import "SiteInstallViewController.h"
#import "DealWarningViewController.h"
#import "AboutViewController.h"

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
    NSArray *itemTitles = @[@"工程信息",@"待办事项",@"收货验货",@"开箱验货",@"站点签到",@"站点安装",@"站点调测",@"告警排障",@"整改闭环",@"完工照片",@"关于工具"];
    NSArray *itemImages = @[@"btn_home_01",@"btn_home_02",@"btn_home_03",@"btn_home_04",@"btn_home_05",@"btn_home_06",@"btn_home_07",@"btn_home_08",@"btn_home_09",@"btn_home_10",@"btn_home_12"];
    HomeUIView* homeView = [[HomeUIView alloc] initWithTitles:itemTitles
                                                    AndImages:itemImages];
    homeView.frame = CGRM(12, 64, self.view.width - 24, self.view.height - 60);
    homeView.acounceTitle = @"发现新版本,请火速更新~~~";
    [self.view addSubview:homeView];
    
    homeView.pageViewHandle = ^(NSInteger tag){
        UIViewController* VC = nil;
        self.Hidden_BackTile = YES;
        NSLog(@"%@",itemTitles[tag-10]);
        switch (tag) {
            case 10:
                //工程信息
            {
                VC = [[ProjectInfoViewController alloc]init];
                BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:VC];
                [self presentToVC:nav];
            }
                break;
            case 11:
                //待办事项
                VC = [[BackLogViewController alloc]init];
                [self pushVC:VC];
                break;
            case 12:
                //收货验货
                VC = [[ReceiveListViewController alloc]init];
                [self pushVC:VC];
                break;
            case 13:
                //开箱验货
                VC = [[OpenBoxViewController alloc]init];
                [self pushVC:VC];
                break;
            case 14:
                //站点签到
                VC = [[SignViewController alloc]init];
                [self pushVC:VC];
                break;
            case 15:
                //站点安装
                VC = [[SiteInstallViewController alloc]init];
                [self pushVC:VC];
                break;
            case 16:
                //站点调测
                VC = [[SiteTestViewController alloc]init];
                [self pushVC:VC];
                break;
            case 17:
                //告警排障
                VC = [[DealWarningViewController alloc]init];
                [self pushVC:VC];
                break;
            case 18:
                //整改闭环
                VC = [[CloseLoopViewController alloc]init];
                [self pushVC:VC];
                break;
            case 19:
                //完工照片
                VC = [[CompletePicViewController alloc]init];
                [self pushVC:VC];
                break;
            case 20:
                VC = [[AboutViewController alloc]init];
                [self pushVC:VC];
                break;
                
            default:
                break;
        }
    };
}

-(void)showUndevelopedHint{
    [self.view hideToasts];
    [self showToast:1.5 withMessage:@"此功能暂未开放"];
}

@end
