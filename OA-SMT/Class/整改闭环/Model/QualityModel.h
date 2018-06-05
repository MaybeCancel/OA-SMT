//
//  QualityModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/2.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface QualityModel : BaseModel

@property (nonatomic, copy) NSString *qualityId;
/*项目名*/
@property (nonatomic, copy) NSString *projectName;
/*站名*/
@property (nonatomic, copy) NSString *stationName;
/*质检日期*/
@property (nonatomic, copy) NSString *inspectDate;
/*整改描述*/
@property (nonatomic, copy) NSString *opinion;
/*0待整改，1完成，2待审核*/
@property (nonatomic, assign) int status;
@end
