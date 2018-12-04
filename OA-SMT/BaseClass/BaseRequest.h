//
//  BaseRequest.h
//  Abroad-agent
//
//  Created by Slark on 17/6/2.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRequest.h"
@interface BaseRequest : NSObject

typedef void(^CCAPICompletion) (NSDictionary * jsonDic);

+ (instancetype)cc_request;
+ (instancetype)cc_requestWithUrl:(NSString*)cc_url;
+ (instancetype)cc_requestWithUrl:(NSString*)cc_url isPost:(BOOL)cc_isPost Params:(NSDictionary*)params;

- (void)cc_sendRequstWith:(CCAPICompletion)completion;
- (void)cc_senRequest;

@property (nonatomic,copy)NSString* cc_url;
@property (nonatomic,strong)UIImage* imageFile;
@property (nonatomic,strong)NSDictionary * cc_params;
@property (nonatomic,assign)BOOL isPost;

//+(NSString*)postImageWithUrl:(NSString *)url postParams:(NSDictionary *)params imageData:(NSData *)data picPath:(NSString *)picPath;

+ (void)UploadImageWithUrl:(NSString*)url params:(NSDictionary *)params image:(UIImage*)image fielName:(NSString *)fileName completion:(CCAPICompletion)completion;



@end
