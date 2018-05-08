//
//  UIFont+IPhoneFont.h
//  Abroad-agent
//
//  Created by Slark on 17/5/22.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (IPhoneFont)
+ (UIFont*)systemWithScreen:(NSInteger)fontNumber;
+ (UIFont*)boldWithScreen:(NSInteger)fontNumber;
@end
