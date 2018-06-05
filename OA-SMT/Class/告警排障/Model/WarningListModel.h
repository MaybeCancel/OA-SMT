//
//  WarningListModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/30.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface WarningListModel : BaseModel
/** 告警Id*/
@property (nonatomic,copy)NSString* alarmId;
/** 项目名称*/
@property (nonatomic,copy)NSString* projectName;
/** 问题时间*/
@property (nonatomic,copy)NSString* alarmDate;
/** 告警描述*/
@property (nonatomic,copy)NSString* alarmNote;
/** 告警等级:1、2、3*/
@property (nonatomic,assign)int alarmLevel;
@end
