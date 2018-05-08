//
//  BaseRequest.m
//  Abroad-agent
//
//  Created by Slark on 17/6/2.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

+ (instancetype)cc_request{
    return [[self alloc]init];
}
+ (instancetype)cc_requestWithUrl:(NSString *)cc_url{
    return [self cc_requestWithUrl:cc_url isPost:NO Params:nil];
}

+ (instancetype)cc_requestWithUrl:(NSString *)cc_url isPost:(BOOL)cc_isPost Params:(NSDictionary *)params{
    BaseRequest * request = [self cc_request];
    request.cc_url = cc_url;
    request.isPost = cc_isPost;
    request.cc_params = params;
    return request;
}

#pragma mark 发送请求
- (void)cc_senRequest{
    [self cc_sendRequstWith:nil];
}

- (void)cc_sendRequstWith:(CCAPICompletion)completion {
    //请求URL
    NSString * urlStr = self.cc_url;
    if (urlStr.length == 0)  return;
    //请求体
    NSDictionary * dic = self.cc_params;

    //普通Post请求
    if (self.isPost) {
        // 处理耗时操作的代码块...
        [MyRequest POST:urlStr withParameters:dic CacheTime:0 isLoadingView:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
             [self handleJsonDic:jsonDic completion:completion];
          
        } failure:^(NSError *error) {
            [LoadingView showAlertHUD:@"网络有问题,请稍后重试" duration:1];
            NSLog(@"请求失败");
            return ;
        }];
    }else{
        [MyRequest GET:urlStr WithParameters:dic CacheTime:0 isLoadingView:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
             [self handleJsonDic:jsonDic completion:completion];
//            if([jsonDic[@"resultCode"] isEqualToString:@"100"]){
//
//                NSLog(@"请求成功处理json");
//            }else if(![jsonDic[@"resultCode"] isEqualToString:@"100"]&&![jsonDic[@"resultCode"] isEqualToString:@"200"]){
//                [LoadingView showAlertHUD:@"网络错误或服务器异常" duration:1];
//                return ;
//            }
        } failure:^(NSError *error) {
            NSLog(@"请求失败");
            return ;
        }];
    }
}
- (void)handleJsonDic:(NSDictionary*)jsonDic completion:(CCAPICompletion)completion{
    [LoadingView hideProgressHUD];
    if (completion) {
        completion(jsonDic);
    }
//    if([jsonDic[@"resultCode"] isEqualToString:@"100"]){
//
//        NSLog(@"请求成功处理json");
//    }else if(![jsonDic[@"resultCode"] isEqualToString:@"100"]&&![jsonDic[@"resultCode"] isEqualToString:@"200"]){
//        [LoadingView showAlertHUD:@"网络错误或服务器异常" duration:1];
//        return ;
//    }
}

@end
