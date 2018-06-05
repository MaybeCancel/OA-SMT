//
//  SiteInstallCell.m
//  OA-SMT
//
//  Created by Slark on 2018/3/13.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SiteInstallCell.h"

@interface SiteInstallCell()
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteNameLab;
@property (weak, nonatomic) IBOutlet UILabel *constructionLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@end

@implementation SiteInstallCell

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 15;
    [super setFrame:frame];
}

-(void)setModel:(InstallSiteModel *)model{
    _model = model;
    self.titleLabel.text = model.projectName;
    self.siteNameLab.text = model.stationName;
    self.constructionLab.text = model.projectName;
    self.dateLab.text = model.optDate;
    if ([model.status isEqual:@0]) {
        self.stateLabel.text = @"未开始";
    }
    else if ([model.status isEqual:@1]){
        self.stateLabel.text = @"已完成";
    }
    else if ([model.status isEqual:@2]){
        self.stateLabel.text = @"进行中";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


@end
