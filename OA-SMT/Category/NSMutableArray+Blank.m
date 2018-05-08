//
//  NSMutableArray+Blank.m
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "NSMutableArray+Blank.h"

@implementation NSMutableArray (Blank)
//重写系统方法 预防添加空值
- (void)cc_addObjec:(id)anObject{
    if (anObject == nil) {
        anObject = @" ";
        [self addObject:anObject];
    }
}

@end
