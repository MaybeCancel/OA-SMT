//
//  BaseTableViewController.h
//  OA-SMT
//
//  Created by Slark on 2018/1/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseTableView.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

/** 表视图*/
@property (nonatomic,strong)BaseTableView* tableView;

/** 分割线颜色*/
@property (nonatomic, assign) UIColor *sepLineColor;

/** 数据源数量*/
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 是否需要系统的cell的分割线*/
@property (nonatomic, assign) BOOL needCellSepLine;

@end
