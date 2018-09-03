//
//  ViewController.m
//  OA-SMT
//
//  Created by Slark on 2017/12/26.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "SMAlert.h"

@interface LoginViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([UserDef objectForKey:@"phone"]) {
        self.userNameText.text = [UserDef objectForKey:@"phone"];
    }
}
- (IBAction)ForgetClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"需要给超级管理员发送邮箱重置账号,确定重置?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"重置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [LoadingView showAlertHUD:@"已发送,请耐心等待" duration:1];
    }];
    
    [alert addAction:cancle];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)LoginClick:(UIButton *)sender {
    [LoadingView showProgressHUD:@""];
    self.userNameText.text = @"18952030057";
    self.passwordText.text = @"123456789";
    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
    if (0) {
        [para setObject:@"13921923093" forKey:@"phone"];
        [para setObject:[@"123456789" md5HexDigest] forKey:@"password"];
    }
    else{
        NSString *password = [self.passwordText.text md5HexDigest];
        [para setObject:self.userNameText.text forKey:@"phone"];
        [para setObject:password forKey:@"password"];
    }

    BaseRequest* request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:Login] isPost:YES Params:para];
    
    [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
        NSLog(@"%@",jsonDic);
        if([jsonDic[@"resultCode"] isEqualToString:@"100"]){
            //101 手机号不存在  102 密码错误
            NSDictionary* dic = jsonDic[@"result"];
            [UserDef setObject:dic[@"phone"] forKey:@"phone"];
            [UserDef setObject:dic[@"userName"] forKey:@"userName"];
            [UserDef setObject:dic[@"userId"] forKey:@"userId"];
            [UserDef setObject:dic[@"email"] forKey:@"email"];
            MainViewController* main = [[MainViewController alloc]init];
            UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:main];
            kWindow.rootViewController = navi;
        }
        else{
            [LoadingView showAlertHUD:jsonDic[@"message"] duration:1.0];
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
