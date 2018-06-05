//
//  CCString.m
//  Abroad-agent
//
//  Created by Slark on 17/6/1.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "CCString.h"
@implementation CCString

+ (NSString*)getHeaderUrl:(NSString *)string{
     return [NSString stringWithFormat:@"%@%@",BASE_URL,string];
}
@end
