//
//  WarningCell.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "WarningCell.h"

@implementation WarningCell
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 15;
    [super setFrame:frame];
}

-(void)setModel:(WarningListModel *)model{
    _model = model;
    self.projectNameLab.text = model.projectName;
    self.alarmDateLab.text = model.alarmDate;
    self.alarmNoteLab.text = model.alarmNote;
    switch (model.alarmLevel) {
        case 11:
            self.alarmLevelLab.text = @"一级";
            self.alarmLevelLab.backgroundColor = RGBColor(244, 99, 99);
            self.tipColor.backgroundColor = RGBColor(244,99, 99);
            break;
        case 12:
            self.alarmLevelLab.text = @"二级";
            self.alarmLevelLab.backgroundColor = RGBColor(253, 153, 107);
            self.tipColor.backgroundColor = RGBColor(253, 153, 107);
            break;
        case 13:
            self.alarmLevelLab.text = @"三级";
            self.alarmLevelLab.backgroundColor = RGBColor(246, 191, 104);
            self.tipColor.backgroundColor = RGBColor(246, 191, 104);
            break;
        case 99:
            self.alarmLevelLab.text = @"其他";
            self.alarmLevelLab.backgroundColor = RGBColor(246, 191, 104);
            self.tipColor.backgroundColor = RGBColor(246, 191, 104);
            break;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.alarmLevelLab.layerCornerRadius = 12;
    self.tipColor.layerCornerRadius = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
