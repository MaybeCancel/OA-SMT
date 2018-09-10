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

+(void)UploadImageWithUrl:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image fielName:(NSString *)fileName completion:(CCAPICompletion)completion{
    NSLog(@"params:%@",params);
    [MyRequest POSTImageUrl:url withParams:params Images:image imageName:fileName success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (completion) {
            completion(jsonDic);
        }
    } failure:^(NSError *error) {
        [LoadingView showAlertHUD:@"网络有问题,请稍后重试" duration:1];
        NSLog(@"请求失败");
        return ;
    }];
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
            NSLog(@"%@",jsonDic);
            [LoadingView hideProgressHUD];
            [self handleJsonDic:jsonDic completion:completion];
        } failure:^(NSError *error) {
            [LoadingView hideProgressHUD];
            [LoadingView showAlertHUD:@"网络有问题,请稍后重试" duration:1];
            NSLog(@"请求失败");
            return ;
        }];
    }else{
        [MyRequest GET:urlStr WithParameters:dic CacheTime:0 isLoadingView:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            [LoadingView hideProgressHUD];
            [self handleJsonDic:jsonDic completion:completion];
        } failure:^(NSError *error) {
            NSLog(@"请求失败");
            [LoadingView hideProgressHUD];
            return ;
        }];
    }
}
- (void)handleJsonDic:(NSDictionary*)jsonDic completion:(CCAPICompletion)completion{
    if (completion) {
        completion(jsonDic);
    }
}



@end
