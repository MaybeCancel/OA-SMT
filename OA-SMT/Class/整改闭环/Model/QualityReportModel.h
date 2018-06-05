//
//  QualityReportModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/4.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface QualityReportModel : BaseModel

@property (nonatomic, copy) NSString *reportId;
/*项目名*/
@property (nonatomic, copy) NSString *projectName;
/*站名*/
@property (nonatomic, copy) NSString *stationName;
/*质检日期*/
@property (nonatomic, copy) NSString *inspectDate;
/*整改描述*/
@property (nonatomic, copy) NSString *opinion;
/*质检工程师*/
@property (nonatomic, copy) NSString *inspector;
/*附件url，以，隔开*/
@property (nonatomic, copy) NSString *attachment;
/*1完成，2未完成*/
@property (nonatomic, assign) int isFinish;
/*遗留问题*/
@property (nonatomic, copy) NSString *question;
/*照片url，以，隔开*/
@property (nonatomic, copy) NSString *imgs;
@end
