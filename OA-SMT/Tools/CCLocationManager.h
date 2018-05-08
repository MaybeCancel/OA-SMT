//
//  CCLocationManager.h
//  Abroad-agent
//
//  Created by Slark on 17/7/18.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void (^CCMapManagerDidUpdateLocationHandle)(CLLocation* newLocation,NSString* newLatitude,NSString* newLongitude);
@interface CCLocationManager : NSObject

+ (instancetype)shareManager;

- (void)starUpDataLocation;

- (void)getNewLocationHandle:(CCMapManagerDidUpdateLocationHandle)locationHandle;

/** 是否可以定位*/
@property (nonatomic,assign)BOOL canLocation;
/** 是否有经纬度*/
@property (nonatomic,assign)BOOL hasLocation;


@end
