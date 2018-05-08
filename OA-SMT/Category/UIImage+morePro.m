//
//  UIImage+morePro.m
//  OA-SMT
//
//  Created by Slark on 2018/2/1.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "UIImage+morePro.h"
static const void *latitudeTag = &latitudeTag;
static const void *longitudeTag = &longitudeTag;
static const void *siteNameTag = &siteNameTag;
static const void *siteNumberTag = &siteNumberTag;
static const void *shootingTimeTag = &shootingTimeTag;
static const void *steeringTag = &steeringTag;
static const void *objectNameTag = &objectNameTag;
static const void *devicePicPartTag = &devicePicPartTag;
static const void *projectIdTag = &projectIdTag;
static const void *deviceIdTag = &deviceIdTag;
static const void *positionIdTag = &positionIdTag;
static const void *stationIdTag = &stationIdTag;

@implementation UIImage (morePro)
@dynamic latitude;
@dynamic longitude;
@dynamic siteName;
@dynamic siteNumber;
@dynamic shootingTime;
@dynamic steering;
@dynamic objectName;
@dynamic devicePicPart;
@dynamic projectId;
@dynamic deviceId;
@dynamic positionId;
@dynamic stationId;

//经度
- (NSString*)longitude{
    return objc_getAssociatedObject(self,longitudeTag);
}
- (void)setLongitude:(NSString *)longitude{
    objc_setAssociatedObject(self, longitudeTag, longitude, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
//纬度
- (void)setLatitude:(NSString *)latitude {
    objc_setAssociatedObject(self, latitudeTag, latitude, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)latitude{
    return objc_getAssociatedObject(self, latitudeTag);
}
//站名
- (void)setSiteName:(NSString *)siteName {
    objc_setAssociatedObject(self, siteNameTag, siteName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)siteName{
    return objc_getAssociatedObject(self, siteNameTag);
}
//站号
- (void)setSiteNumber:(NSString *)siteNumber {
    objc_setAssociatedObject(self, siteNumberTag, siteNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)siteNumber{
    return objc_getAssociatedObject(self, siteNumberTag);
}
//拍摄时间
- (void)setShootingTime:(NSString *)shootingTime{
    objc_setAssociatedObject(self, shootingTimeTag, shootingTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)shootingTime{
    return objc_getAssociatedObject(self, shootingTimeTag);
}
//督导
- (void)setSteering:(NSString *)steering{
    objc_setAssociatedObject(self, steeringTag, steering, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)steering{
    return objc_getAssociatedObject(self, steeringTag);
}

//项目名称
- (void)setObjectName:(NSString *)objectName{
    objc_setAssociatedObject(self, objectNameTag, objectName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)objectName{
    return objc_getAssociatedObject(self, objectNameTag);
}

//设备位置
- (void)setDevicePicPart:(NSString *)devicePicPart{
    objc_setAssociatedObject(self, devicePicPartTag, devicePicPart, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)devicePicPart{
    return objc_getAssociatedObject(self, devicePicPartTag);
}

- (void)setProjectId:(NSString *)projectId{
    objc_setAssociatedObject(self, projectIdTag, projectId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)projectId{
    return objc_getAssociatedObject(self, projectIdTag);
}



- (void)setDeviceId:(NSString *)deviceId{
    objc_setAssociatedObject(self, deviceIdTag, deviceId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)deviceId{
    return objc_getAssociatedObject(self, deviceIdTag);
}

- (void)setPositionId:(NSString *)positionId{
    objc_setAssociatedObject(self, positionIdTag, positionId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)positionId{
    return objc_getAssociatedObject(self, positionIdTag);
}
- (void)setStationId:(NSString *)stationId{
    objc_setAssociatedObject(self, stationIdTag, stationId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)stationId{
    return objc_getAssociatedObject(self, stationIdTag);
}

- (void)loadInfoFromModel:(SiteInfoModel *)model{
    self.stationId = model.stationId;
    self.longitude = model.longitude;
    self.latitude = model.latitude;
    self.siteNumber = model.siteNumber;
    self.siteName = model.siteName;
    self.steering = model.steering;
    self.objectName = model.objectName;
    self.devicePicPart = [NSString stringWithFormat:@"%@[%@]",model.PicPosition,model.detaiPart];
    self.shootingTime = model.shootingTime;
    self.projectId = model.projectId;
    self.deviceId = model.deviceId;
    self.positionId = model.positionId;
    NSLog(@"照片部位:~~~~%@",self.devicePicPart);
}

@end
