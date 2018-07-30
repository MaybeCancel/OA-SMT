//
//  AddItemBtnView.h
//  OA-SMT
//
//  Created by Slark on 2018/1/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemBtnView : UIView
+ (instancetype)shareAddItem;
@property (nonatomic,copy)void (^addHanle)(void);
@property (strong, nonatomic) IBOutlet UILabel *leftTitle;
@property (nonatomic,copy)NSString* leftTitleString;
@end
