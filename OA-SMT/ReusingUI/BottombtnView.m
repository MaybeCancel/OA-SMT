//
//  BottombtnView.m
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BottombtnView.h"

@implementation BottombtnView

+ (instancetype)shareBottomBtnView{
    return [[[NSBundle mainBundle] loadNibNamed:@"BottombtnView" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.leftBottomBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBottomBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)leftClick:(UIButton*)btn{
    if (self.leftBottombtnHandle) {
        self.leftBottombtnHandle();
    }
}
- (void)rightClick:(UIButton*)btn{
    if (self.rightBottombtnHandle) {
        self.rightBottombtnHandle();
    }
}
- (void)setLeftBtnTitle:(NSString *)leftBtnTitle{
    _leftBtnTitle = leftBtnTitle;
    [self.leftBottomBtn setTitle:_leftBtnTitle forState:UIControlStateNormal];
}
- (void)setLeftBtnBgColor:(UIColor *)leftBtnBgColor{
    _leftBtnBgColor = leftBtnBgColor;
    [self.leftBottomBtn setBackgroundColor:leftBtnBgColor];
}
- (void)setLeftBtnTitleColor:(UIColor *)leftBtnTitleColor{
    _leftBtnTitleColor = leftBtnTitleColor;
    [self.leftBottomBtn setTitleColor:_leftBtnTitleColor forState:UIControlStateNormal];
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle{
    _rightBtnTitle = rightBtnTitle;
    [self.rightBottomBtn setTitle:_rightBtnTitle forState:UIControlStateNormal];
}
- (void)setRightBtnBgColor:(UIColor *)rightBtnBgColor{
    _rightBtnBgColor = rightBtnBgColor;
    [self.leftBottomBtn setBackgroundColor:_rightBtnBgColor];
}
- (void)setRightBtnTitleColor:(UIColor *)rightBtnTitleColor{
    _rightBtnTitleColor = rightBtnTitleColor;
    [self.leftBottomBtn setTitleColor:_rightBtnTitleColor forState:UIControlStateNormal];
}

@end
