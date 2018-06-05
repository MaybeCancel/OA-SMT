//
//  signModel.h
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface signModel : BaseModel
/** 站号*/
@property (nonatomic,copy)NSString* stationNumber;

/** 站名*/
@property (nonatomic,copy)NSString* stationName;

/** 施工类型*/
@property (nonatomic,copy)NSString* stationType;

/** 施工类型字符串*/
@property (nonatomic,copy)NSString* stationTypeStr;

/** 经度*/
@property (nonatomic,copy)NSString* longitude;

/** 纬度*/
@property (nonatomic,copy)NSString* latitude;

/** 我的位置*/
@property (nonatomic,copy)NSString* currentLocation;

/** 签到时间*/
@property (nonatomic,copy)NSString* currentTime;

/** 施工ID*/
@property (nonatomic,copy)NSString* stationId;
@end
