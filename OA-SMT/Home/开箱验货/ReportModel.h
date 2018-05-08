//
//  ReportModel.h
//  OA-SMT
//
//  Created by Slark on 2018/2/28.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface ReportModel : BaseModel
/** 区域*/
@property (nonatomic,copy)NSString* city;
/** 省份*/
@property (nonatomic,copy)NSString* province;
/** 运营商*/
@property (nonatomic,copy)NSString* clientName;
/** 网络制式*/
@property (nonatomic,copy)NSString* networkType;
/** 项目*/
@property (nonatomic,copy)NSString* projectName;
/** POCode*/
@property (nonatomic,copy)NSString* poCode;
/** 内部订单号*/
@property (nonatomic,copy)NSString* orderCode;
/** 物流单号*/
@property (nonatomic,copy)NSString* logisticsCode;
/** 站点*/
@property (nonatomic,copy)NSString* stationName;
/** 货运号*/
@property (nonatomic,copy)NSString* freightCode;
/** 箱号*/
@property (nonatomic,copy)NSString* packageCode;
/** 箱数*/
@property (nonatomic,copy)NSString* packageNum;
/** 级别*/
@property (nonatomic,copy)NSString* level;
/** 产品型号*/
@property (nonatomic,copy)NSString* modelCode;
/** 描述*/
@property (nonatomic,copy)NSString* note;
/** 箱内数量*/
@property (nonatomic,copy)NSString* totalCount;
/** 序列号*/
@property (nonatomic,copy)NSString* serialCode;
/** 开箱日期*/
@property (nonatomic,copy)NSString* optDate;
/** 开箱站点ID*/
@property (nonatomic,copy)NSString* optStationId;
/** 货物问题描述*/
@property (nonatomic,copy)NSString* optNote;

@end
