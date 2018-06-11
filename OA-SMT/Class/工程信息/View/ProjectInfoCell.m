//
//  ProjectInfoCellTableViewCell.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/6/4.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ProjectInfoCell.h"

@interface ProjectInfoCell()

@end

@implementation ProjectInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
}

-(void)setRowDatas:(NSArray *)rowDatas{
    _rowDatas = rowDatas;
    for (int i = 0; i < rowDatas.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRM(i*itemWidth, 0, itemWidth, itemHeight)];
        label.text = rowDatas[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:label];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
