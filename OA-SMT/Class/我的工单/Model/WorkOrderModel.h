//
//  WorkOrderModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/8/29.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface WorkOrderModel : BaseModel

@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *missionDetails;
@property (nonatomic, copy) NSString *principal;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, copy) NSString *stationType;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, strong) NSArray *workOrderAttachment;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, copy) NSString *workOrderName;
@property (nonatomic, assign) int workOrderTypeId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *typeOfGoods;
@property (nonatomic, strong) NSNumber *isSolve;
@end
