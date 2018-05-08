//
//  StateModel.h
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateModel : BaseModel
/** 工程类别*/
@property (nonatomic,copy)NSString* projectType;
/** 站点ID*/
@property (nonatomic,copy)NSString* stationId;
/** 站点编号*/
@property (nonatomic,copy)NSString* stationCode;
/** 站点地址*/
@property (nonatomic,copy)NSString* stationAddress;
/** 站点名称*/
@property (nonatomic,copy)NSString* stationName;

@end
