//
//  DeviceModel.h
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"

@interface DeviceModel : BaseModel
@property (nonatomic,copy)NSString* shortName;
@property (nonatomic,copy)NSString* photoDevice;
@property (nonatomic,copy)NSString* id;
@property (nonatomic,strong)NSArray* photoPositions;

@end
