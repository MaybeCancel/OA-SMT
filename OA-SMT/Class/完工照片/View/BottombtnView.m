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
    self.leftLab.layerCornerRadius = 9;
    self.rightLab.layerCornerRadius = 9;
    [self.topBottomBtn addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
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
- (void)topClick:(UIButton*)btn{
    if (self.topBottombtnHandle) {
        self.topBottombtnHandle();
    }
}

-(void)setUploadNum:(int)uploadNum hasUploadNum:(int)hasUploadNum{
    if (uploadNum == 0) {
        self.leftLab.hidden = YES;
    }
    else{
        self.leftLab.hidden = NO;
        self.leftLab.text = [NSString stringWithFormat:@"%d",uploadNum];
    }
    if (hasUploadNum == 0) {
        self.rightLab.hidden = YES;
    }
    else{
        self.rightLab.hidden = NO;
        self.rightLab.text = [NSString stringWithFormat:@"%d",hasUploadNum];
    }
}

@end
