//
//  UIFont+IPhoneFont.m
//  Abroad-agent
//
//  Created by Slark on 17/5/22.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "UIFont+IPhoneFont.h"

@implementation UIFont (IPhoneFont)
+ (UIFont*)systemWithScreen:(NSInteger)fontNumber{
    if (is_iPHONE5) {
        fontNumber = fontNumber-2;
    }
    else if (is_iPHONE6P) {
        fontNumber = fontNumber+1;
    }
    return [UIFont systemFontOfSize:fontNumber];
}
+ (UIFont*)boldWithScreen:(NSInteger)fontNumber{
    if (is_iPHONE5) {
        fontNumber = fontNumber-1;
    }
    else if (is_iPHONE6P) {
        fontNumber = fontNumber+1;
    }
    return [UIFont boldSystemFontOfSize:fontNumber];
}

@end
