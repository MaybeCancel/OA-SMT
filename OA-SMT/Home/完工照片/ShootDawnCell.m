//
//  ShootDawnCell.m
//  OA-SMT
//
//  Created by Slark on 2018/1/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ShootDawnCell.h"

@implementation ShootDawnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBtn_Delete:(BOOL)btn_Delete{
    _btn_Delete = btn_Delete;
     self.deleteBtn.hidden = _btn_Delete;
}
- (void)setLeftSpace:(CGFloat)leftSpace{
    _leftSpace = leftSpace;
    self.itemSpace.constant = _leftSpace;
}
- (void)deleteClick{
    if (self.deleteBtnHandle) {
        self.deleteBtnHandle();
    }
}
@end
