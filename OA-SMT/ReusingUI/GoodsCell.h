//
//  GoodsCell.h
//  OA-SMT
//
//  Created by Slark on 2018/1/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodListModel.h"
@interface GoodsCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *TipColor;


/** 客户PO号*/
@property (strong, nonatomic) IBOutlet UILabel *PONumber;
/** 收货状态*/
@property (strong, nonatomic) IBOutlet UILabel *ReceiveState;
/** 内部订单号*/
@property (strong, nonatomic) IBOutlet UILabel *NeiNumber;
/** 物流单号*/
@property (strong, nonatomic) IBOutlet UILabel *WuNumber;
/** 货运号*/
@property (strong, nonatomic) IBOutlet UILabel *HuoNumber;
/** 箱数*/
@property (strong, nonatomic) IBOutlet UILabel *BoxNumber;
- (void)loadDataFromModel:(GoodListModel*)model;

@end
