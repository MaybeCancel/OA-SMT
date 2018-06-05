//
//  BaseTableViewController.m
//  OA-SMT
//
//  Created by Slark on 2018/1/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
- (void)viewDidLoad{
    [super viewDidLoad];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

@end
