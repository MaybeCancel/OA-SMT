//
//  HomeUIView.h
//  OA-SMT
//
//  Created by Slark on 2017/12/26.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeUIView : UIView
/* 模块点击回调**/
@property (nonatomic,copy)void (^pageViewHandle)(NSInteger tag);
/* 公告点击回调**/
@property (nonatomic,copy)void (^acounceHanle)(void);
/* 公告内容**/
@property (nonatomic,copy)NSString* acounceTitle;
/* 一行多少个模块**/
@property (nonatomic,assign)int rowNumber;

/*
 * titles 标题名字数组
 * images 图片名字数组
 **/
- (instancetype)initWithTitles:(NSArray<NSString*>*)titles AndImages:(NSArray<NSString*>*)images;

@end
