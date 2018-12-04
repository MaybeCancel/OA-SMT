//
//  PostListViewController.h
//  OA-SMT
//
//  Created by Slark on 2018/1/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewController.h"
#import "WorkOrderModel.h"

@interface PostListViewController : BaseTableViewController
@property (nonatomic,strong)NSMutableArray* shootedArray;
@property (nonatomic,strong)NSMutableArray* hasUploadMArr;
@property (nonatomic, strong) WorkOrderModel *model;
@end
