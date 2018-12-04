//
//  ChoseSiteViewController.h
//  OA-SMT
//
//  Created by Slark on 2018/1/11.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseViewController.h"
#import "WorkOrderModel.h"

@interface ChoseSiteViewController : BaseTableViewController
@property (nonatomic, copy) void (^siteBack)(NSDictionary *siteDic);
@property (nonatomic, copy) NSString* siteInfo;
@property (nonatomic,strong) NSArray* infoArray;
@property (nonatomic, copy) NSString *stationId;
@end
