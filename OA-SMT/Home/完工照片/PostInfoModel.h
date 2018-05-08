//
//  PostInfoModel.h
//  OA-SMT
//
//  Created by Slark on 2018/1/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostInfoModel : NSObject
@property (nonatomic,copy)NSString* siteName;


/** 需要上传的图片*/
@property (nonatomic,strong)UIImage* image;
@end
