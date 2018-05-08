//
//  BaseModel.m
//  cars-agent
//
//  Created by Slark on 17/1/16.
//  Copyright © 2017年 colander. All rights reserved.
//

#import "BaseModel.h"
@implementation BaseModel
+ (id)ModelWithDic:(NSDictionary*)dic{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        return [self mj_objectWithKeyValues:dic];
    }
    return [[self alloc]init];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (instancetype)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
