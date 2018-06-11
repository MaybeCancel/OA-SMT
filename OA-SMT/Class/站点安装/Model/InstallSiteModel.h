//
//  InstallSiteModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/19.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface InstallSiteModel : BaseModel
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *stationId;
@property (nonatomic, copy) NSString *stationName;
@property (nonatomic, copy) NSString *constructionteam;
@property (nonatomic, copy) NSString *optDate;
//0：未开始 1：进行中 2：已完成
@property (nonatomic, strong) NSNumber *status;
@end
