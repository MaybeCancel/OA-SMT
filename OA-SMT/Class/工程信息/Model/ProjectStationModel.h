//
//  ProjectStationModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/4.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface ProjectStationModel : BaseModel
@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, copy) NSString *stationCode;
@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, copy) NSString *receiveDate;
@property (nonatomic, copy) NSString *checkoutDate;
@property (nonatomic, copy) NSString *installDate;
@property (nonatomic, copy) NSString *testDate;
@property (nonatomic, copy) NSString *inspectDate;
@property (nonatomic, copy) NSString *rectifyDate;
@property (nonatomic, copy) NSString *acceptDate;
@end
