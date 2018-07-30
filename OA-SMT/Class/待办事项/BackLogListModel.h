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
#import "InstallSiteModel.h"

@interface BackLogListModel : BaseModel
@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) int type;

//收货验货（开箱验货）
@property (nonatomic, strong) GoodListModel *logisticsInfo;
//告警列表
@property (nonatomic, strong) WarningListModel *alarmList;
//站点安装（站点调测）
@property (nonatomic, strong) InstallSiteModel *installInfo;

@end
