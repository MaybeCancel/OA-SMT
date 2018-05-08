//
//  ViewController.m
//  OA-SMT
//
//  Created by Slark on 2017/12/26.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "MyRequest.h"
#import "SMAlert.h"
@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)ForgetClick:(UIButton *)sender {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"需要给超级管理员发送邮箱重置账号,确定重置?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重置", nil];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
       //
    }else if (buttonIndex == 1){
        //进行重置操作
        NSLog(@"重置");
        [LoadingView showAlertHUD:@"已发送,请耐心等待" duration:1];
    }
}


- (IBAction)LoginClick:(UIButton *)sender {
    MainViewController* main = [[MainViewController alloc]init];
    UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:main];
    [self presentViewController:navi animated:YES completion:nil];
//    //网络请求有问题 待修改
//    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:@"account/login"] isPost:YES Params:@{@"phone":@"2121",@"password":@"123456"}];
//    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
//        if([jsonDic[@"resultCode"] isEqualToString:@"100"]){
//            //101 手机号不存在  102 密码错误
//            NSDictionary* dic = jsonDic[@"result"];
//            [Default setObject:dic[@"phone"] forKey:@"phone"];
//            [Default setObject:dic[@"userName"] forKey:@"userName"];
//            [Default setObject:dic[@"userId"] forKey:@"userId"];
//            [Default setObject:dic[@"email"] forKey:@"email"];
//            MainViewController* main = [[MainViewController alloc]init];
//            UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:main];
//            [self presentViewController:navi animated:YES completion:nil];
//        }
//    }];
}

- (void)jbwang{
    //1.先用for循环创建一横排3个文字标签
    for (NSInteger i = 0; i < 3; i ++) {
        //创建标签
        UILabel* label = [[UILabel alloc]init];
        //设置标签文字内容
        label.text = @"JBWANG";
        //坐标  假设Label的宽高都是40 每个标签的间距为0
        label.frame = CGRectMake(0+(40*i), 0, 40, 40);
        //添加到页面
        [self.view addSubview:label];
    }

   // NSArray* labels = @[@"工程信息",@"待办事项",@"收获验货",@"开箱验货",@"站点签到",@"站点安装",@"站点调测",@"告警排障",@"整改闭环",@"完工照片",@"变动申请",@"关于工具"];
    
    
    
    //1.首先观察他是个3*4的UI表格
    
    //从0开始计算, 第二个的意思是循环的范围(你需要创建12个图 所以就是循环12次,从开始查到11就是12次,所以是小于12)   第三个i++的意思是 完成一次函数操作 i就++一次
   // for(int i = 0; i < 12;i ++){
        //首先要想你要在循环里面干嘛
        //你要创建一个图片视图  还要创建一个文字标签 即: UIIimageView  和 UILabel
        //创建一个文字标签
    //    UILabel* label = [[UILabel alloc]init];
        //创建了标签就要设置他的内容
    //    label.text = @"123";
        //创建完了内容发现内容是固定的,怎么办?这个时候你就需要一个数组容器,然后跟循环里面的i对应,最上面创建了labels数组
    //    label.text = labels[i];
        
        //最重要的是设置文字标签的坐标frame 坐标需要自己计算,你可以一步一步来 先创建一横排3个
   //     label.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        
        //创建一个图片视图
    //    UIImageView* imageView =  [[UIImageView alloc]init];
   // }
    
    
    
}


@end
