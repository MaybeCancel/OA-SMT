//
//  GoodListModel.h
//  OA-SMT
//
//  Created by Slark on 2018/2/27.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseModel.h"
@interface GoodListModel : BaseModel
/** 项目Id*/
@property (nonatomic,copy)NSString* goodsId;
/** 客户PO号*/
@property (nonatomic,copy)NSString* poCode;
/** 内部订单号*/
@property (nonatomic,copy)NSString* orderCode;
/** 物流单号*/
@property (nonatomic,copy)NSString* logisticsCode;
/** 货运号*/
@property (nonatomic,copy)NSString* freightCode;
/** 箱数*/
@property (nonatomic,copy)NSString* packageNum;
/** 状态:0未开箱 1已收货 2问题货物*/
@property (nonatomic,assign)int status;
@end
