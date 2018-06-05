//
//  signCell.h
//  OA-SMT
//
//  Created by Slark on 2018/1/23.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SignRecodeModel.h"
@interface signCell : BaseTableViewCell
@property (strong, nonatomic) IBOutlet UILabel *signTime;
@property (strong, nonatomic) IBOutlet UILabel *stationNameNumber;
@property (strong, nonatomic) IBOutlet UILabel *projectType;
@property (strong, nonatomic) IBOutlet UILabel *longitude;

@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *myLocation;


- (void)loadDataFromModel:(SignRecodeModel*)model;
@end
