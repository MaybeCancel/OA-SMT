//
//  WorkOrderModel.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/8/29.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "WorkOrderModel.h"

@implementation WorkOrderModel

-(NSArray *)imageArr{
    if (!_imageArr) {
        NSMutableArray *imgMArr = [NSMutableArray new];
        for (NSDictionary *dic in self.workOrderAttachment) {
            NSString *imgUrl = [NSString stringWithFormat:@"%@/%@",BASE_IMGURL,dic[@"attachmentName"]];
            [imgMArr addObject:imgUrl];
        }
        _imageArr = [NSArray arrayWithArray:imgMArr];
    }
    return _imageArr;
}

@end
