//
//  CCLocationManager.m
//  Abroad-agent
//
//  Created by Slark on 17/7/18.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "CCLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface CCLocationManager()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager* locationManager;
@property (nonatomic,weak)CLLocation * location;
@end
static CCLocationManager* _singleLocation = nil;

@implementation CCLocationManager{
    CCMapManagerDidUpdateLocationHandle _locationHandle;
}

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _singleLocation= [[CCLocationManager alloc]init];
    });
    return _singleLocation;
}

- (void)starUpDataLocation{
    if ([CLLocationManager locationServicesEnabled]) {
        self.canLocation = YES;
        self.locationManager = [[CLLocationManager alloc]init];//初始化定位对象
        self.locationManager.delegate = self;//设置代理
        // [self.locationManager requestAlwaysAuthorization];//一直访问
        [self.locationManager requestWhenInUseAuthorization];//使用时访问
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//
        self.locationManager.distanceFilter = 5.0;//多久刷新一次
        [self.locationManager startUpdatingLocation];//开启更新位置信息
    }
}
- (void)getNewLocationHandle:(CCMapManagerDidUpdateLocationHandle)locationHandle{
    _locationHandle = locationHandle;
}
#pragma mark Location-Delegate (定位代理)
//如果定位失败就调用这个方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败了");
    //设置提示用户去打开定位服务
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alert addAction:ok];
//    [alert addAction:cancel];
    
}

#pragma mark 获取当前经纬度 来获取附近人信息
//定位成功的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    self.hasLocation = YES;
    CLLocation* currentLocation = [locations lastObject];//获取定位数组中最新的值
    NSLog(@"当前位置的纬度%f,当前位置的经度%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    if (_locationHandle) {
        [self.locationManager stopUpdatingLocation];
        _locationHandle(currentLocation,[NSString stringWithFormat:@"%.6f",currentLocation.coordinate.latitude],[NSString stringWithFormat:@"%.6f",currentLocation.coordinate.longitude]);
            //地理反编码 - - 可以根据地理坐标(经纬度)确定位置信息(街道门牌)
//            CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
//            [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//                if(placemarks.count>0){
//                    CLPlacemark* placeMark = placemarks[0];
//                    [Default setObject:placeMark.country forKey:@"country"];
//                    [Default setObject:placeMark.locality forKey:@"city"];
//                    NSLog(@"当前国家为:%@",placeMark.country);//当前国家
//                    NSLog(@"当前城市为:%@",placeMark.locality);//当前城市
//                    NSLog(@"当前位置%@",placeMark.subLocality);//当前的位置
//                    NSLog(@"当前街道%@",placeMark.thoroughfare);//当前街道
//                    NSLog(@"具体地址%@",placeMark.name);//具体地址: XX市 XX区 XX街道
//                }
//            }];
        
    }
   
}



@end
