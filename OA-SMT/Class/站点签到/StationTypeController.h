//
//  ConstructionTypeController.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/19.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewController.h"

@interface StationTypeController : BaseTableViewController
@property (nonatomic,copy)void (^stationTypeBlock)(NSString *stationType,int type);
@end
