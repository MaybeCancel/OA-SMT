//
//  signCell.m
//  OA-SMT
//
//  Created by Slark on 2018/1/23.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "signCell.h"

@implementation signCell
- (void)loadDataFromModel:(SignRecodeModel *)model{
    self.signTime.text = [NSString stringWithFormat:@"%@",model.signinDate];
    self.stationNameNumber.text = [NSString stringWithFormat:@"%@ %@",model.stationName,model.stationCode];
    self.projectType.text = [NSString stringWithFormat:@"施工类型:%@",[self param:model.optType]];
    self.longitude.text = [NSString stringWithFormat:@"经度:%@",model.longitude];
    self.latitude.text = [NSString stringWithFormat:@"纬度:%@",model.latitude];
    self.myLocation.text = [NSString stringWithFormat:@"我的位置:%@",model.address];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (NSString*)param:(NSString*)string{
    int a = [string intValue];
    switch (a) {
        case 0:
            return @"验货";
            break;
        case 1:
            return @"安装";
            break;
        case 2:
            return @"调测";
            break;
        case 3:
            return @"整改";
            break;
        case 4:
            return @"其他";
            break;
    }
    return @"";
}


@end
