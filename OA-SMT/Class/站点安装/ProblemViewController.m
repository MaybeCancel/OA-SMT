//
//  ProblemViewController.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/19.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ProblemViewController.h"

@interface ProblemViewController ()<UITextViewDelegate>
{
    UILabel *_placeholderLab;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextView *problemTextFld;

@end

@implementation ProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"遗留问题";
    self.rightItemTitle = @"提交";
    kWeakSelf(weakSelf);
    self.rightItemHandle = ^{
        NSLog(@"提交遗留问题");
        if (weakSelf.problemTextFld.text.length) {
            if (weakSelf.feedbackBlock) {
                weakSelf.feedbackBlock(weakSelf.problemTextFld.text);
                [weakSelf pop];
            }
        }
        else{
            [LoadingView showAlertHUD:@"问题不能为空" duration:1];
        }
    };
    [self setupUI];
}

-(void)setupUI{
    _placeholderLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 25)];
    _placeholderLab.enabled = NO;
    _placeholderLab.text = @"请填写遗留问题";
    _placeholderLab.font =  [UIFont systemFontOfSize:17];
    _placeholderLab.textColor = [UIColor lightGrayColor];
    [self.problemTextFld addSubview:_placeholderLab];
    
    self.titleLab.text = self.numberStr;
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [_placeholderLab setHidden:NO];
    }else{
        [_placeholderLab setHidden:YES];
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
