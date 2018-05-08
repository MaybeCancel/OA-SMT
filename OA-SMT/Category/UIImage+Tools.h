//
//  UIImage+Tools.h
//  OA-SMT
//
//  Created by Slark on 2018/1/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)
/**
 * 将视图转化为图片
 */
+ (UIImage*)imageWithUIView:(UIView*)view;


/**
 * 将一张图片打水印到另外一张图片上
 * logoImage 原图
 * watemarkImage 水印图
 * logoImageRect 原图frame
 * watemarkImageRect 水印图frame
 */
+ (UIImage *)addWatemarkImageWithLogoImage:(UIImage *)logoImage watemarkImage:(UIImage *)watemarkImage logoImageRect:(CGRect)logoImageRect watemarkImageRect:(CGRect)watemarkImageRect;


/**
 * 在图片上添加文字水印
 * image 原图
 * text 文字信息
 * rect 水印坐标
 */
+ (UIImage *)waterMarkImage:(UIImage *)image withText:(NSString *)text withFrame:(CGRect)rect;



@end
