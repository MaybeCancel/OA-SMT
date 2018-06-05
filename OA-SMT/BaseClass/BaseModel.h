//
//  BaseModel.h
//  cars-agent
//
//  Created by Slark on 17/1/16.
//  Copyright © 2017年 colander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : JSONModel
+ (id)ModelWithDic:(NSDictionary*)dic;

@end
