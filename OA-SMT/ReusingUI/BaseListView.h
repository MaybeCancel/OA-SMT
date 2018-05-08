//
//  BaseListView.h
//  OA-SMT
//
//  Created by Slark on 2018/2/27.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseListView : UIView
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightImage;
@property (nonatomic,copy)NSString* leftString;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,copy)void (^tapHandle)(void);
+ (instancetype)baseListView;
@end
