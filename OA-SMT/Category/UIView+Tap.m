//
//  UIView+Tap.m
//  CCFounctionKit
//
//  Created by Slark on 17/2/7.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "UIView+Tap.h"
#import <objc/runtime.h>
/**
 * 动态添加手势
 */
static const char *TapKey;
@implementation UIView (Tap)
- (void)addTapActionWithBlock:(void (^)(void))block{
    self.userInteractionEnabled = YES;//先打开用户交互 本质是一个View
    //通过tapKey来获取关联对象
    UITapGestureRecognizer * tap = objc_getAssociatedObject(self, &TapKey);
    
    //判断是否存在手势 如果没有通过key获取到对象那就重新创建在进行关联
    if (!tap) {
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDownActionForTapGesture:)];//创建手势
        [self addGestureRecognizer:tap];//添加手势到View
        
        /*
         *进行手势与自身关联  关联值为TapKey 最后一个参数 "OBJC_ASSOCIATION_RETAIN" RETAIN 来修饰关联的对象是什么属性 有ASSIGN COPY等
         **/
        objc_setAssociatedObject(self, &TapKey, tap,OBJC_ASSOCIATION_RETAIN);
    }
    /*
     *复制关联对象 TapKey与block关联
     **/
    objc_setAssociatedObject(self, &TapKey, block, OBJC_ASSOCIATION_COPY);
    
}
- (void)tapDownActionForTapGesture:(UITapGestureRecognizer*)tap{
    //判断手势的状态 如果是被触发状态
    if (tap.state==UIGestureRecognizerStateRecognized) {
        //创建新的block 通过关联的tapKet来接收参数里面的Block
        void(^action)(void) =objc_getAssociatedObject(self, &TapKey);
        if(action){
            action();//触发blaock
        }
    }
}



@end
