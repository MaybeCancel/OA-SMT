//
//  TimeTools.m
//  OA-SMT
//
//  Created by Slark on 2018/1/12.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "TimeTools.h"

@implementation TimeTools

+ (NSString*)getCurrentTimesWithFormat:(NSString *)formatString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

@end
