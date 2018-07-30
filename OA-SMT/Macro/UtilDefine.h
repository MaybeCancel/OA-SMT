//
//  UtilDefine.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#ifndef UtilDefine_h
#define UtilDefine_h

//获取window
#define kWindow     [UIApplication sharedApplication].keyWindow

//weakSelf
#define kWeakSelf(weakSelf) __weak typeof(self) weakSelf = self;

//屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//宏定义宽高比例
#define AutoScaleWidth(a)  a / 375.0 * SCREEN_WIDTH
#define AutoScaleHeight(a)  a / 667.0 * SCREEN_HEIGHT

//CGRectMake
#define CGRM(x,y,w,d) CGRectMake(x, y, w, d)

//view的布局信息
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

//颜色定义
#define RGBColor(r,g,b)   [UIColor colorWithRed:((float)(r))/255.0 green:((float)(g))/255.0 blue:((float)(b))/255.0 alpha:1.0f]
#define BackgroungColor RGB(252,252,252,1.0) //#Fcfcfc

//NSUserDefaults
#define UserDef [NSUserDefaults standardUserDefaults]

//NSTimer
#define IntervalTime 30

//版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//手机机型
#define is_iPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size)) : NO)

#define is_iPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#endif /* UtilDefine_h */
