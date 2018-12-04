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
#import "LoginViewController.h"
#import "WorkOrderViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) HomeUIView* homeView;
@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    kWeakSelf(weakSelf);
    self.barColor = RGBColor(75, 151, 252);
    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:GetMessage] isPost:YES Params:@{}];
    
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        if([jsonDic[@"resultCode"] isEqualToString:@"100"]){
            NSArray *result = jsonDic[@"result"];
            if (result.count) {
                weakSelf.homeView.acounceTitleArr = result;
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBColor(75, 151, 252);
    self.title = @"爱立信站点辅助管理系统";
    
    NSArray *itemTitles = @[@"我的工单 ",@"关于ESMT",@"退出"];
    self.homeView = [[HomeUIView alloc] initWithTitles:itemTitles];
    
    if (is_iPhoneXS) {
        self.homeView.frame = CGRM(12, 88, self.view.width - 24, self.view.height - 60);
    }
    else{
        self.homeView.frame = CGRM(12, 64, self.view.width - 24, self.view.height - 60);
    }
    
    self.homeView.acounceTitleArr = @[@"暂无通知"];
    [self.view addSubview:self.homeView];

    
    kWeakSelf(weakSelf);
    self.homeView.pageViewHandle = ^(NSInteger tag){
        UIViewController* VC = nil;
        weakSelf.Hidden_BackTile = YES;
        NSLog(@"%@",itemTitles[tag-10]);
        switch (tag) {
            case 10:
                //我的工单
                VC = [[WorkOrderViewController alloc]init];
                [weakSelf pushVC:VC];
                break;
//            case 11:
//                //变动申请
//                [weakSelf showUndevelopedHint];
//                break;
            case 11:
                //工具维护
                VC = [[AboutViewController alloc]init];
                [weakSelf pushVC:VC];
                break;
            case 12:
                //退出
            {
                VC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                VC = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
                kWindow.rootViewController = VC;
                break;
            }
            default:
                break;
        }
    };
}

-(void)showUndevelopedHint{
    [self.view hideToasts];
    [self showToast:1.5 withMessage:@"此功能暂未开放"];
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

@end
