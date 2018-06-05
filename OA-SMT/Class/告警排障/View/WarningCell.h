//
//  WarningCell.h
//  OA-SMT
//
//  Created by Slark on 2018/3/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "WarningListModel.h"

@interface WarningCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tipColor;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLab;

@property (weak, nonatomic) IBOutlet UILabel *alarmLevelLab;

@property (weak, nonatomic) IBOutlet UILabel *alarmDateLab;
@property (weak, nonatomic) IBOutlet UILabel *alarmNoteLab;

@property (nonatomic, strong) WarningListModel *model;

@end
