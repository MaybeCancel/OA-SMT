//
//  CCString.m
//  Abroad-agent
//
//  Created by Slark on 17/6/1.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "CCString.h"
@implementation CCString
static NSString* baseUrl = @"http://120.27.232.247:8088/EricssonApp";
//static NSString* baseUrl = @"http://27.115.24.94:8881/EricssonApp";


//+ (NSString*)getImageFromUrl:(NSString*)string{
//    return [NSString stringWithFormat:@"%@%@",ImageUrl,string];
//}

+ (NSString*)getHeaderUrl:(NSString *)string{
     return [NSString stringWithFormat:@"%@/%@",baseUrl,string];
}
@end
