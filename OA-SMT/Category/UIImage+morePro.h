//
//  UIImage+morePro.h
//  OA-SMT
//
//  Created by Slark on 2018/2/1.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteInfoModel.h"
@interface UIImage (morePro)
/**经度 */
@property (nonatomic,copy)NSString* longitude;
/**纬度 */
@property (nonatomic,copy)NSString* latitude;
/**站号*/
@property (nonatomic,copy)NSString* siteNumber;
/**站名*/
@property (nonatomic,copy)NSString* siteName;
/**督导 */
@property (nonatomic,copy)NSString* steering;
/**项目名称 */
@property (nonatomic,copy)NSString* objectName;
/**照片位置 */
@property (nonatomic,copy)NSString* devicePicPart;
/**拍摄时间 */
@property (nonatomic,copy)NSString* shootingTime;
/**项目ID */
@property (nonatomic,copy)NSString* projectId;
/**站点ID */
@property (nonatomic,copy)NSString* stationId;
/**照片设备ID */
@property (nonatomic,copy)NSString* deviceId;
/**照片部位ID */
@property (nonatomic,copy)NSString* positionId;

- (void)loadInfoFromModel:(SiteInfoModel*)model;

@end
