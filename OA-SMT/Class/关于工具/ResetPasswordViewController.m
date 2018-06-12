

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
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextF;
@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    self.saveBtn.layer.cornerRadius = 5;
    self.oldPasswordTextF.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTextF.keyboardType = UIKeyboardTypeASCIICapable;
    self.surePasswordTextF.keyboardType = UIKeyboardTypeASCIICapable;
}

- (IBAction)saveNewPasswordClick:(id)sender {
    NSString *message = @"";
    if (self.oldPasswordTextF.text.length < 6 ||
        self.passwordTextF.text.length < 6 ||
        self.surePasswordTextF.text.length < 6) {
        message = @"新旧密码不能低于6位";
    }
    else if (![self.passwordTextF.text isEqualToString:self.surePasswordTextF.text]){
        message = @"新密码两次输入不匹配";
    }
    if (message.length) {
        [LoadingView showAlertHUD:message duration:1.0];
    }
    else{
        NSMutableDictionary *para = [NSMutableDictionary new];
        [para setObject:[UserDef objectForKey:@"phone"] forKey:@"phone"];
        [para setObject:[self.passwordTextF.text md5HexDigest] forKey:@"password"];
        
        BaseRequest *request = [BaseRequest cc_requestWithUrl:[CCString getHeaderUrl:ChangePassword] isPost:YES Params:para];
        [request cc_sendRequstWith:^(NSDictionary *jsonDic) {
            if([jsonDic[@"resultCode"] isEqualToString:@"100"]){
                [self performSelector:@selector(resetRootViewController) withObject:nil afterDelay:1.0];
                [LoadingView showAlertHUD:@"密码修改成功" duration:1.0];
            }
            else{
                [LoadingView showAlertHUD:jsonDic[@"message"] duration:1.0];
            }
        }];
    }
}

-(void)resetRootViewController{
    // 1.获取当前的StoryBoard面板
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 2.通过标识符找到对应的页面
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    kWindow.rootViewController = vc;
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
