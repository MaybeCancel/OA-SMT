//
//  GoodsCell.m
//  OA-SMT
//
//  Created by Slark on 2018/1/8.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell
- (void)setFrame:(CGRect)frame{
    frame.size.height -= 15;
    [super setFrame:frame];
}

-(void)setModelData:(GoodListModel *)model isReceive:(BOOL)isReceive{
    self.PONumber.text = [NSString stringWithFormat:@"客户PO号:%@",model.poCode];
    switch (model.status) {
        case 0:
            if (isReceive) {
                self.ReceiveState.text = @"未收货";
            }
            else{
                self.ReceiveState.text = @"未开箱";
            }
            self.ReceiveState.backgroundColor = RGBColor(74, 141, 232);
            self.TipColor.backgroundColor = RGBColor(74,141, 232);
            break;
        case 1:
            self.ReceiveState.text = @"已收货";
            self.ReceiveState.backgroundColor = RGBColor(204, 204, 204);
            self.TipColor.backgroundColor = RGBColor(204, 204, 204);
            break;
        case 2:
            self.ReceiveState.text = @"问题货物";
            self.ReceiveState.backgroundColor = RGBColor(245, 99, 100);
            self.TipColor.backgroundColor = RGBColor(245, 99, 100);
            break;
    }
    self.NeiNumber.text = model.orderCode;
    self.WuNumber.text = model.logisticsCode;
    self.HuoNumber.text = model.freightCode;
    self.BoxNumber.text = model.packageNum;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.ReceiveState.layerCornerRadius = 12;
    self.TipColor.layerCornerRadius = 2;
}


@end
