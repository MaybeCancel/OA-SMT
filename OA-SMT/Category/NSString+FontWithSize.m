//
//  NSString+FontWithSize.m
//  Abroad-agent
//
//  Created by Slark on 17/6/19.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "NSString+FontWithSize.h"

@implementation NSString (FontWithSize)
+ (CGSize)stringSize:(NSString *)string AndFont:(NSInteger)font{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemWithScreen:font]};
    CGSize size=[string sizeWithAttributes:attrs];
    return size;
}
+ (CGSize)stringWidthAndHeightWith:(NSString*)string Font:(NSInteger)font{
    CGSize titleSize = [string boundingRectWithSize:CGSizeMake(ScreenWidth-48, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return titleSize;
    
}
@end
