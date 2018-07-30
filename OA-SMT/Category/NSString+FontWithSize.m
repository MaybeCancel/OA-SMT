//
//  NSString+FontWithSize.m
//  Abroad-agent
//
//  Created by Slark on 17/6/19.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "NSString+FontWithSize.h"

@implementation NSString (FontWithSize)

-(CGFloat)realHeightFromWidth:(CGFloat)width Font:(NSInteger)font{
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return titleSize.height;
}

-(CGFloat)realWidthFromHeight:(CGFloat)height Font:(NSInteger)font{
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return titleSize.width;
}
@end
