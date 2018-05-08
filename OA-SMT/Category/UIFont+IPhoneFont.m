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
    int SWidth  = ScreenWidth;
    switch (SWidth) {
        case IPHONE5WIDTH:
            fontNumber = fontNumber-2;
            break;
        case IPHONE6WIDTH:
            break;
        case IPHONE6PWIDTH:
            fontNumber = fontNumber+1;
            break;
        default:
            break;
    }
    return [UIFont systemFontOfSize:fontNumber];
}
+ (UIFont*)boldWithScreen:(NSInteger)fontNumber{
    int SWidth  = ScreenWidth;
    switch (SWidth) {
        case IPHONE5WIDTH:
            fontNumber = fontNumber-1;
            break;
        case IPHONE6WIDTH:
            break;
        case IPHONE6PWIDTH:
            fontNumber = fontNumber+1;
            break;
        default:
            break;
    }
    return [UIFont boldSystemFontOfSize:fontNumber];
}

@end
