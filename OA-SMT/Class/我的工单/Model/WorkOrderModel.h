//
//  WorkOrderModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/8/29.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface WorkOrderModel : BaseModel
//businessId = 96;
//endDate = "2018-03-30 17:26:37";
//id = 6;
//missionDetails = "\U6d4b\U8bd5";
//principal = "\U4e00\U9875\U4e66";
//priority = "\U666e\U901a";
//projectId = 13;
//schedule = "\U672a\U5b8c\U7ed3";
//serialNumber = 2018082823;
//startDate = "2018-03-30 17:26:37";
//stationName = "\U4ed9\U70751";
//workOrderAttachment =             (
//);
//workOrderName = "\U6536\U8d27\U8d27\U7269";
//workOrderTypeId = 1;
@property (nonatomic, copy) NSString *businessId;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *missionDetails;
@property (nonatomic, copy) NSString *principal;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, strong) NSArray *workOrderAttachment;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, copy) NSString *workOrderName;
@property (nonatomic, assign) int workOrderTypeId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *typeOfGoods;
@property (nonatomic, strong) NSNumber *isSolve;
@end
