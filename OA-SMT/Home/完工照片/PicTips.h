//
//  PicTips.h
//  OA-SMT
//
//  Created by Slark on 2018/1/12.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteInfoModel.h"
@interface PicTips : UIView
/** 项目名称*/
@property (strong, nonatomic) IBOutlet UILabel *objectName;
/** 站点名称*/
@property (strong, nonatomic) IBOutlet UILabel *siteNumber;
/** 站点名字*/
@property (strong, nonatomic) IBOutlet UILabel *siteName;
/** 督导*/
@property (strong, nonatomic) IBOutlet UILabel *steering;
/** 经度*/
@property (strong, nonatomic) IBOutlet UILabel *longtitude;
/** 纬度*/
@property (strong, nonatomic) IBOutlet UILabel *latitude;
/** 照片部位*/
@property (strong, nonatomic) IBOutlet UILabel *picPosition;
/** 当前时间*/
@property (strong, nonatomic) IBOutlet UILabel *currentTime;

+ (instancetype)shareShootPic;

- (void)loadInfoFromModel:(SiteInfoModel*)model;

@end
