

//
//  ResetPasswordViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "LoginViewController.h"

@interface ResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *oldPasswordTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;

@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextF;
@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    self.saveBtn.layer.cornerRadius = 5;
}

- (IBAction)saveNewPasswordClick:(id)sender {
    kWindow.rootViewController = [LoginViewController new];
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
