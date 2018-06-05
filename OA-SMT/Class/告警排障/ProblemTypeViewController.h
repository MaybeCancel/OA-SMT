//
//  ProblemTypeViewController.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/31.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ProblemTypeViewController : BaseTableViewController
@property (nonatomic, copy) void(^problemTypeBlock)(NSString *problemType,int type);
@property (nonatomic, assign) int selectedIndex;
@end
