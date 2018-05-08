//
//  UIView+Tap.h
//  CCFounctionKit
//
//  Created by Slark on 17/2/7.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)
/**
 *添加手势
 */
-(void)addTapActionWithBlock:(void(^)(void))block;
@end
