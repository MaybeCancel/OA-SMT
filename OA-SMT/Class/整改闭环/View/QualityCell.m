//
//  SiteInstallCell.m
//  OA-SMT
//
//  Created by Slark on 2018/3/13.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "QualityCell.h"

@interface QualityCell()
@property (weak, nonatomic) IBOutlet UILabel *tipColor;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteNameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *describeLab;
@end

@implementation QualityCell

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 15;
    [super setFrame:frame];
}

-(void)setModel:(QualityModel *)model{
    _model = model;
    self.titleLabel.text = model.projectName;
    self.siteNameLab.text = model.stationName;
    self.dateLab.text = model.inspectDate;
    self.describeLab.text = model.opinion;
    
    if (model.status == 0) {
        self.stateLabel.text = @"待整改";
        self.stateLabel.backgroundColor = RGBColor(74, 142, 233);
    }
    else if (model.status == 1){
        self.stateLabel.text = @"完成";
        self.stateLabel.backgroundColor = RGBColor(204, 204, 204);
    }
    else if (model.status == 2){
        self.stateLabel.text = @"待审核";
        self.stateLabel.backgroundColor = RGBColor(87, 202, 197);
    }
    self.tipColor.backgroundColor = self.stateLabel.backgroundColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.stateLabel.layerCornerRadius = 12;
    self.tipColor.layerCornerRadius = 2;
}


@end
