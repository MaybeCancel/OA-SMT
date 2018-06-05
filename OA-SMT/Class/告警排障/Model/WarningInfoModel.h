//
//  WarningInfoModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/31.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface WarningInfoModel : BaseModel
//告警id
@property (nonatomic, copy)NSString *alarmId;
//项目名称
@property (nonatomic, copy)NSString *projectName;
//问题时间
@property (nonatomic, copy)NSString *alarmDate;
//告警描述
@property (nonatomic, copy)NSString *alarmNote;
//告警级别
@property (nonatomic, assign)int alarmLevel;
//创建人
@property (nonatomic, copy)NSString *userName;
//附件 以，隔开
@property (nonatomic, copy)NSString *attachment;
//是否解决 0未解决；1已解决
@property (nonatomic, copy)NSString *isSolve;
//遗留问题类型
@property (nonatomic, assign)int questionType;
//遗留问题
@property (nonatomic, copy)NSString *question;
//照片 以，隔开
@property (nonatomic, copy)NSString *imgs;
@end
