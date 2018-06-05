//
//  NSString+FontWithSize.h
//  Abroad-agent
//
//  Created by Slark on 17/6/19.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FontWithSize)
- (CGFloat)realHeightFromWidth:(CGFloat)width Font:(NSInteger)font;
@end
