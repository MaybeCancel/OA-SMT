//
//  UIView+Layer.h
//  CCFounctionKit
//
//  Created by Slark on 17/2/6.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)
- (void)setLayerCornerRadius:(CGFloat)cornerRadius
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor;
/**
 *  边角半径
 */
@property (nonatomic, assign) CGFloat layerCornerRadius;
/**
 *  边线宽度
 */
@property (nonatomic, assign) CGFloat layerBorderWidth;
/**
 *  边线颜色
 */
@property (nonatomic, strong) UIColor *layerBorderColor;
@end
