//
//  QualityReportModel.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/4.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "QualityReportModel.h"

@implementation QualityReportModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"reportId":@"id",
             };
}
@end
