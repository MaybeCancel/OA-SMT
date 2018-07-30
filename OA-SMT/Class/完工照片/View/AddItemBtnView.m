//
//  AddItemBtnView.m
//  OA-SMT
//
//  Created by Slark on 2018/1/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "AddItemBtnView.h"

@implementation AddItemBtnView
+ (instancetype)shareAddItem{
    return [[[NSBundle mainBundle] loadNibNamed:@"AddItemBtnView" owner:nil options:nil] lastObject];
}
- (IBAction)addClick:(UIButton *)sender {
    if(self.addHanle){
        self.addHanle();
    }
}
- (void)setLeftTitleString:(NSString *)leftTitleString{
    _leftTitleString = leftTitleString;
    _leftTitle.text = _leftTitleString;
}


@end
