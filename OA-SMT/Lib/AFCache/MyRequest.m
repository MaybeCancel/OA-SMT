//
//  MyRequest.m
//  AFCache
//
//  Created by tc on 2016/11/10.
//  Copyright © 2016年 tc. All rights reserved.
//
#define IsNilString(__String)   (__String==nil || [__String isEqualToString:@"null"] || [__String isEqualToString:@"<null>"])

#import "MyRequest.h"
#import "AFNetworking.h"
#import "EGOCache.h"
#import "LoadingView.h"
#import "Reachability.h"
@implementation MyRequest

#pragma mark get
+(void)GET:(NSString *)url WithParameters:(NSDictionary*)paramas CacheTime:(NSInteger)CacheTime isLoadingView:(NSString *)loadString success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
    EGOCache *cache = [EGOCache globalCache];
    if (![self interStatus]) {
         //无网络
        NSString *interNetError = [url stringByAppendingString:@"interNetError"];
        NSData *responseObject = [cache dataForKey:interNetError];
        if (responseObject.length != 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(responseObject,YES,dict);
            return;
        }
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];

    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    
    if ([cache hasCacheForKey:url]) {
        NSData *responseObject = [cache dataForKey:url];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(responseObject,YES,dict);
        return;
    }
    
   
    
    [manager GET:url parameters:paramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!IsNilString(loadString)) {
            [LoadingView hideProgressHUD];
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        BOOL succe = NO;
        success(responseObject,succe,dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (!IsNilString(loadString)) {
            [LoadingView hideProgressHUD];
        }
        [LoadingView showAlertHUD:@"网络没有连接上" duration:2];
        
        failure(error);
    }];
}
#pragma mark post
+ (void)POST:(NSString *)url withParameters:(NSDictionary *)params CacheTime:(NSInteger)CacheTime isLoadingView:(NSString *)loadString success:(SuccessCallBack)success failure:(FailureCallBack)failure
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    EGOCache *cache = [EGOCache globalCache];
    if (![self interStatus]) {
        //无网络
        NSString *interNetError = [url stringByAppendingString:@"interNetError"];
        NSData *responseObject = [cache dataForKey:interNetError];
        if ((responseObject.length != 0)) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(responseObject,YES,dict);
            return;
        }
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//声明返回的数据是json
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//声明请求的数据是json
    //设置请求头
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    if ([cache hasCacheForKey:url]) {
        NSData *responseObject = [cache dataForKey:url];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(responseObject,YES,dict);
        return;
    }
    
    NSLog(@"请求url：%@\n请求参数：%@",url,params);

    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        BOOL succe = YES;
//        NSLog(@"回参:%@",dict);
        success(responseObject,succe,dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"报错:%@",error);
        failure(error);
    }];
}

+ (void)POSTImageUrl:(NSString *)url withParams:(NSDictionary *)params Images:(UIImage *)image imageName:(NSString *)imageName success:(SuccessCallBack)success failure:(FailureCallBack)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];//声明返回的数据是json
    manager.requestSerializer =[AFJSONRequestSerializer serializer];//声明请求的数据是json
    //设置请求头
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *name = [formatter stringFromDate:[NSDate date]];
        
        //上传操作
        NSData* data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@_SMT",name] fileName:imageName mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"上传成功了啊啊啊：%@",dict);
        BOOL succe = YES;
         success(responseObject,succe,dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败了");
        failure(error);
    }];
    /*
     1、name:多文件上传时,name不能重复，不能重复，不能重复，重要的事情说三遍，我就是在这里卡住了，当时我的接口文档中让我传的参数是“photos[]”,结果我真的傻乎乎的只传了一个“photos[]”,其结果就是只有一张图片上传成功，这也体现了交流的重要性，至于具体怎么传，接口文档一般都有说明，如不清楚，请与后台人员沟通，这是服务器用于接收你所上传文件的参数名，十分重要。
     
     　　2、fileName:不能重复，这个名字由用户决定，只要不重复，其它没有要求。
     
     　　3、mimeType:你所要上传文件的类型，各种文件所对应的类型详情请自己百度。
     
     　　上传图片一般会与相册与照相机结合使用，但是其图片一般较大，可使用UIImageJPEGRepresentation(image, 0.1)方法对图片进行一定程度的压缩，具体压缩情况要结合你的实例。作一点说明：UIImagePNGRepresentation(image)与UIImageJPEGRepresentation(image, 0.1)方法都会返回图片的data数据，如果将data数据转化成图片，图片类型由后缀名决定，如果保存为.png后缀的图片，就是png图片，如果保存为.jpg后缀的图片，则就是jpg图片，故不要被方法名中的PNG和JPEG所影响。
     
     　　最后，提醒一下大家：有时候你可能碰到上传图片的网络请求失败，从而会怀疑自己是不是用错了方法，如果你的文件上传是利用multipart/form-data请求上传，则使用上述方法是没有错的，这时你需要与你的后台成员多进行沟通，因为错的并不一定是你，自信一点。
     
     
     */
    
    
}
//同步判断网络状态，可能在部分iOS系统会卡顿iOS9 iOS10没有问题
+(BOOL)interStatus
{
    BOOL status ;
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus status22 = [reach currentReachabilityStatus];
    
     // 判断网络状态
    if (status22 == ReachableViaWiFi) {
        
        status = YES;
        //无线网
    } else if (status22 == ReachableViaWWAN) {
        status = YES;
        //移动网
    } else {
        status = NO;
        
    }
    
    return status;
}



@end
