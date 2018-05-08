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
- (void)loadDataFromModel:(GoodListModel *)model{
    self.PONumber.text = [NSString stringWithFormat:@"客户PO号:%@",model.poCode];
    switch (model.status) {
        case 0:
            self.ReceiveState.text = @"未开箱";
            self.ReceiveState.backgroundColor = RGBColor(56, 117, 231);
            self.TipColor.backgroundColor = RGBColor(56, 117, 231);
            break;
        case 1:
            self.ReceiveState.text = @"已收货";
            self.ReceiveState.backgroundColor = RGBColor(193, 193, 193);
            self.TipColor.backgroundColor = RGBColor(193, 193, 193);
            break;
        case 2:
            self.ReceiveState.text = @"问题货物";
            self.ReceiveState.backgroundColor = RGBColor(242, 73, 78);
            self.TipColor.backgroundColor = RGBColor(242, 73, 78);
            break;
    }
    self.NeiNumber.text = model.orderCode;
    self.WuNumber.text = model.logisticsCode;
    self.HuoNumber.text = model.freightCode;
    self.BoxNumber.text = model.packageNum;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.ReceiveState.layerCornerRadius = 5;
    self.ReceiveState.layerBorderWidth = 1;
    self.TipColor.layerCornerRadius = 2;
}


@end
