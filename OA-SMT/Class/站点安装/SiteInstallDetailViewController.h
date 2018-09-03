//
//  SiteInstallDetailViewController.h
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/18.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewController.h"
#import "InstallSiteModel.h"

@interface SiteInstallDetailViewController : BaseTableViewController
@property (nonatomic, strong) InstallSiteModel *model;
@property (nonatomic,assign)int status;
@end
