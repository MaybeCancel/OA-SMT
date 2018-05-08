//
//  SignRecodeModel.h
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface SignRecodeModel : BaseModel
/** 站号*/
@property (nonatomic,copy)NSString* stationCode;

/** 站名*/
@property (nonatomic,copy)NSString* stationName;

/** 施工类型*/
@property (nonatomic,copy)NSString* optType;

/** 经度*/
@property (nonatomic,copy)NSString* longitude;

/** 纬度*/
@property (nonatomic,copy)NSString* latitude;

/** 我的位置*/
@property (nonatomic,copy)NSString* address;

/** 签到时间*/
@property (nonatomic,copy)NSString* signinDate;


@end
