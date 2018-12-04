//
//  HasUploadPhotoModel.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/9/28.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

//id = 584,
//stationId = 356,
//uploadUser = "谭松辉",
//resourceId = "/FD5G23E_尹东八村CRFD_室内地线【室内保护地线排】.jpg",
//longitude = "118.875451",
//latitude = "31.993468",
//deviceId = 14,
//userId = 28,
//address = "江苏省南京市江宁区永胜路312号靠近华庭南园社区卫生服务站",
//photoDate = "2018-09-28 13:05:24",
//projectId = 12,
//positionId = 1202,

@interface HasUploadPhotoModel : BaseModel

@property (nonatomic,copy)NSString* id;
@property (nonatomic,copy)NSString* stationId;
@property (nonatomic,copy)NSString* uploadUser;
@property (nonatomic,copy)NSString* resourceId;
@property (nonatomic,copy)NSString* longitude;
@property (nonatomic,copy)NSString* latitude;
@property (nonatomic,copy)NSString* deviceId;
@property (nonatomic,copy)NSString* userId;
@property (nonatomic,copy)NSString* address;
@property (nonatomic,copy)NSString* photoDate;
@property (nonatomic,copy)NSString* projectId;
@property (nonatomic,copy)NSString* positionId;

@end
