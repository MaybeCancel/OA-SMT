//
//  ProblemTypeCell.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/31.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ProblemTypeCell.h"

@implementation ProblemTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectImg.hidden = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
