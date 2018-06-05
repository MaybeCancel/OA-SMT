//
//  SignBtnView.m
//  OA-SMT
//
//  Created by Slark on 2018/1/23.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SignBtnView.h"

@implementation SignBtnView

+ (instancetype)shareSignBtnView{
    return [[[NSBundle mainBundle]loadNibNamed:@"SignBtnView" owner:nil options:nil]lastObject];
}

- (IBAction)signTouchDown:(id)sender {
    if (self.signHandle) {
        self.signHandle();
    }
}
- (IBAction)reLocationTouchDown:(id)sender {
    if (self.reloacationHandle) {
        self.reloacationHandle();
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.signBtn.layerCornerRadius = self.signBtn.width/2;
}

- (void)setSignSuccess:(BOOL)signSuccess{
    _signSuccess = signSuccess;
    if (_signSuccess) {
        //如果签到成功 修改按钮状态
        //self.signBtn state
    }
}

@end
