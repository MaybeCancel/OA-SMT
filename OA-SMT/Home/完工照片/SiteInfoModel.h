//
//  SiteInfoModel.h
//  OA-SMT
//
//  Created by Slark on 2018/1/12.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiteInfoModel : NSObject
/**设备具体位置*/
@property (nonatomic,copy)NSString* detaiPart;
/** 设备及照片部位*/
@property (nonatomic,copy)NSString* PicPosition;
/** 工程类型*/
@property (nonatomic,copy)NSString* objectType;
/** 项目名称*/
@property (nonatomic,copy)NSString* objectName;
/** 站号*/
@property (nonatomic,copy)NSString* siteNumber;
/** 站名*/
@property (nonatomic,copy)NSString* siteName;
/** 督导*/
@property (nonatomic,copy)NSString* steering;
/** 经度*/
@property (nonatomic,copy)NSString* longitude;
/** 纬度*/
@property (nonatomic,copy)NSString* latitude;
/** 我的位置*/
@property (nonatomic,copy)NSString* myLocation;
/** 拍摄时间*/
@property (nonatomic,copy)NSString* shootingTime;
/** 站号站名信息*/
@property (nonatomic,strong)NSArray* stationInfoArray;
/**项目ID */
@property (nonatomic,copy)NSString* projectId;
/**站点ID */
@property (nonatomic,copy)NSString* stationId;
/**照片设备ID */
@property (nonatomic,copy)NSString* deviceId;
/**照片部位ID */
@property (nonatomic,copy)NSString* positionId;
@end
