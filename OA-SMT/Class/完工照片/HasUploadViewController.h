//
//  HasUploadViewController.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/13.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewController.h"

@interface HasUploadViewController : BaseTableViewController
@property (nonatomic,strong)NSMutableArray* hasUploadMArr;
@property (nonatomic,copy)NSString* stationId;
@property (nonatomic,copy)NSString* projectId;

@end
