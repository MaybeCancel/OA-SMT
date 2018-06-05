//
//  InstallReportCell.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/5/18.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "InstallReportCell.h"

@implementation InstallReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedImage.hidden = YES;
    // Initialization code
}
- (IBAction)hasProblemAction:(id)sender {
    if (self.hasProblemHandle) {
        self.hasProblemHandle();
    }
}

-(void)setModel:(CellStateModel *)model{
    _model = model;
    if (!model.state) {
        self.selectedImage.hidden = YES;
        [self.problemBtn setImage:[UIImage imageNamed:@"btn_problem_h"] forState:(UIControlStateNormal)];
        self.problemBtn.userInteractionEnabled = YES;
    }
    else{
        self.selectedImage.hidden = NO;
        [self.problemBtn setImage:[UIImage imageNamed:@"btn_problem"] forState:(UIControlStateNormal)];
        self.problemBtn.userInteractionEnabled = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
