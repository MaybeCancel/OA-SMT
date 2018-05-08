//
//  StateListViewController.h
//  OA-SMT
//
//  Created by Slark on 2018/1/24.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewController.h"
#import "StateModel.h"
@interface StateListViewController : BaseTableViewController
@property (nonatomic,copy)void (^stateInfoHandle)(StateModel* model);
@end
