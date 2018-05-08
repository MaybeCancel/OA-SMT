//
//  ReceiveGoodReportViewController.h
//  OA-SMT
//
//  Created by Slark on 2018/2/27.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseViewController.h"

@interface ReceiveGoodReportViewController : BaseTableViewController
@property (nonatomic,copy)NSString* goodsId;
@property (nonatomic,assign)BOOL isReceive;
@property (nonatomic,copy)NSString* boxTitle;
@property (nonatomic,copy)NSString* headTitle;
@end
