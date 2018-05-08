//
//  BaseCell.m
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setArrowHidden:(BOOL)arrowHidden{
    _arrowHidden = arrowHidden;
    self.arrowImage.hidden = _arrowHidden;
}


@end
