//
//  ProjectInfoModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/4.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface ProjectListModel : BaseModel
@property (nonatomic, copy) NSString *projectId;
@property (nonatomic, copy) NSString *projectName;
@end

@protocol ProjectListModel<NSObject>

@end

@interface ProjectInfoModel : BaseModel
@property (nonatomic, copy) NSString *clientId;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, strong) NSArray <ProjectListModel> *projectList;
@end


