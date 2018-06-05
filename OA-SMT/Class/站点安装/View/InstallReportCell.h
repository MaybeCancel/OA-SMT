//
//  InstallReportCell.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/18.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CellStateModel.h"

@interface InstallReportCell : BaseTableViewCell
@property (nonatomic,copy)void (^hasProblemHandle)(void);
@property (weak, nonatomic) IBOutlet UIButton *selectedImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *problemBtn;
@property (nonatomic, strong) CellStateModel *model;
@end
