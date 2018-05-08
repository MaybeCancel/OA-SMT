//
//  HomeBtnView.h
//  OA-SMT
//
//  Created by Slark on 2017/12/26.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBtnView : UIView
@property (nonatomic,copy)NSString* imageName;//图片名字
@property (nonatomic,copy)NSString* title;//按钮标题

- (instancetype)initWithTitle:(NSString*)title AndImageName:(NSString*)name;
- (void)ViewToIdenty;
- (void)ViewToBig;
@end




