//
//  BackLogListModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/1.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"
#import "GoodListModel.h"
#import "WarningListModel.h"

@interface BackLogListModel : BaseModel
@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) int type;

@property (nonatomic, strong) GoodListModel *logisticsInfo;

@property (nonatomic, strong) WarningListModel *alarmList;

@end
