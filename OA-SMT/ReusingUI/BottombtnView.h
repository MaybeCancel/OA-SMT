//
//  BottombtnView.h
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottombtnView : UIView
@property (nonatomic,copy)void (^leftBottombtnHandle)(void);
@property (nonatomic,copy)void (^rightBottombtnHandle)(void);
@property (nonatomic,copy)NSString* leftBtnTitle;
@property (nonatomic,copy)NSString* rightBtnTitle;
@property (nonatomic,strong)UIColor* leftBtnBgColor;
@property (nonatomic,strong)UIColor* leftBtnTitleColor;

@property (nonatomic,strong)UIColor* rightBtnBgColor;
@property (nonatomic,strong)UIColor* rightBtnTitleColor;
@property (strong, nonatomic) IBOutlet UIButton *leftBottomBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBottomBtn;

+ (instancetype)shareBottomBtnView;

@end
