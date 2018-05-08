//
//  DeviceHighCell.m
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "DeviceHighCell.h"

@implementation DeviceHighCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedBackgroundView = [[UIView alloc]init];
    
}
- (void)loadString:(NSString *)string{
    self.leftLabel.text = string;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    if (selected) {
        self.leftLabel.textColor = RGBColor(60, 119, 231);
        self.lineView.backgroundColor =RGBColor(60, 119, 231);
    }else{
        self.leftLabel.textColor = RGBColor(30,30,30);
        self.lineView.backgroundColor =RGBColor(231, 231, 231);
    }
}

@end
