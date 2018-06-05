//
//  NSDate+DateFormat.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/29.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "NSDate+DateFormat.h"

@implementation NSDate (DateFormat)

+(NSString *)dateStringWithFormat:(NSString *)dateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = dateFormat;
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    return dateStr;
}

@end
