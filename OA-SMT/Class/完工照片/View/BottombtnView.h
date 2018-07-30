//
//  BottombtnView.h
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottombtnView : UIView
@property (nonatomic,copy)void (^topBottombtnHandle)(void);
@property (nonatomic,copy)void (^leftBottombtnHandle)(void);
@property (nonatomic,copy)void (^rightBottombtnHandle)(void);
@property (strong, nonatomic) IBOutlet UIButton *leftBottomBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBottomBtn;
@property (weak, nonatomic) IBOutlet UIButton *topBottomBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

+ (instancetype)shareBottomBtnView;

-(void)setUploadNum:(int)uploadNum hasUploadNum:(int)hasUploadNum;

@end
