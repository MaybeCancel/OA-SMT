//
//  BaseListImageView.h
//  OA-SMT
//
//  Created by Slark on 2018/3/6.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseListImageView : UIView
//图片轮播视图
@property (nonatomic,strong)NSMutableArray* images;
@property (nonatomic,copy)NSString* topString;
@property (nonatomic,copy)NSString* btnTitle;

@property (nonatomic,copy)void (^btnClickAction)(void);

@end
