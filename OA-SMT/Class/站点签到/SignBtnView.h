//
//  SignBtnView.h
//  OA-SMT
//
//  Created by Slark on 2018/1/23.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignBtnView : UIView
@property (strong, nonatomic) IBOutlet UIButton *signBtn;
@property (strong, nonatomic) IBOutlet UIButton *reLocationBtn;
@property (nonatomic,copy) void (^signHandle)(void);
@property (nonatomic,copy)void (^reloacationHandle)(void);
@property (nonatomic,assign)BOOL signSuccess;

+ (instancetype)shareSignBtnView;
@end
