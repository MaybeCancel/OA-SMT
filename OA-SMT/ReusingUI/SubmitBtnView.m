//
//  SubmitBtnView.m
//  OA-SMT
//
//  Created by Maybe_文仔 on 2018/9/3.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "SubmitBtnView.h"

@interface SubmitBtnView()
@property (nonatomic, strong) UIButton *submitBtn;
@end

@implementation SubmitBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.submitBtn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.top.mas_equalTo(self.mas_top).mas_offset(15);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-15);
    }];
}

-(void)submitAction{
    if (self.SubmitBlock) {
        self.SubmitBlock();
    }
}

#pragma mark -- LazyLoad

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc]init];
        _submitBtn.layerBorderWidth = 1.0f;
        _submitBtn.layerBorderColor = [UIColor blackColor];
        _submitBtn.layerCornerRadius = 8;
        [_submitBtn setTitle:@"提 交" forState:(UIControlStateNormal)];
        [_submitBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _submitBtn;
}

@end
