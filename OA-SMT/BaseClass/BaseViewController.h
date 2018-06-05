//
//  BaseViewController.h
//  ios-2Block
//
//  Created by Slark on 17/1/12.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController
@property (nonatomic,assign)BOOL Hidden_BackTile;
//item文字标题
@property (nonatomic,copy)NSString* rightItemTitle;
//右边item图片名称
@property (nonatomic,copy)NSString* rightItemImageName;
//点击item回调
@property (nonatomic,copy)void (^rightItemHandle)(void);
//返回刷新页面的block
@property (nonatomic,copy)void (^refreshBlock)(void);
//返回箭头颜色
@property (nonatomic,strong)UIColor* arrowColor;
//title颜色
@property (nonatomic,strong)UIColor* titleColor;
//bar背景色
@property (nonatomic,strong)UIColor* barColor;
/** 判断是否有网络*/
@property (nonatomic,assign)BOOL isNetworrReachable;
- (void)presentToVC:(UIViewController*)vc;
- (void)dismiss;
- (void)pushVC:(UIViewController*)vc;
- (void)pop;
- (void)popToRootVc;
- (void)popToVc:(UIViewController*)vc;
- (void)addchildVc:(UIViewController*)childVc;
- (void)removeChildVc:(UIViewController*)childVc;

/** 加载数据交给子类实现*/
- (void)loadData;
- (void)setupSubviews;
- (void)OpenAlbumAlert;
- (void)openAlbum;
- (void)openCamera;
- (NSString *)updateTimeForTimeInterval:(NSInteger)timeInterval;

//toast
- (void)showToast:(NSTimeInterval)duration withMessage:(NSString *)message;
@end
