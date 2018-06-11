//
//  PicTips.m
//  OA-SMT
//
//  Created by Slark on 2018/1/12.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "PicTips.h"

@implementation PicTips

+ (instancetype)shareShootPic{
    return [[[NSBundle mainBundle] loadNibNamed:@"PicTips" owner:nil options:nil] lastObject];
}
- (void)loadInfoFromModel:(SiteInfoModel *)model{
    self.objectName.text = model.objectName;
    self.siteName.text = model.siteName;
    self.siteNumber.text = model.siteNumber;
    self.steering.text = model.steering;
    self.longtitude.text = model.longitude;
    self.latitude.text = model.latitude;
    self.picPosition.text = [NSString stringWithFormat:@"%@[%@]",model.PicPosition,model.detaiPart];
    self.currentTime.text = model.shootingTime;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

@end
