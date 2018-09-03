//
//  HomeUIView.m
//  OA-SMT
//
//  Created by Slark on 2017/12/26.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "HomeUIView.h"
#import "HomeBtnView.h"
#import "YFRollingLabel.h"

@implementation HomeUIView{
    NSArray* _titles;
    UIImageView* _anounceImage;
    YFRollingLabel* _contentLabel;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles{
    self = [super init];
    if (self) {
        _titles = titles;
        self.layerCornerRadius = 3;
        self.backgroundColor = RGBColor(245, 245, 245);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    _anounceImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"公告"]];
    _anounceImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_anounceImage];
    
    for(NSInteger i = 0; i < _titles.count; i++){
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i + 10;
        btn.layerBorderWidth = 1.0;
        btn.layerBorderColor = RGBColor(75, 151, 252);
        btn.layerCornerRadius = 5.0;
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitle:_titles[i] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(onClickItem:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
    }
}
- (void)onClickItem:(UIButton *)sender{
    //获取点击tag
    if(self.pageViewHandle){
        self.pageViewHandle(sender.tag);
    }
}

-(void)setAcounceTitleArr:(NSArray *)acounceTitleArr{
    _acounceTitleArr = acounceTitleArr;
    
    if (_contentLabel) {
        [_contentLabel removeFromSuperview];
        _contentLabel = nil;
    }
    _contentLabel = [[YFRollingLabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)
                                               textArray:acounceTitleArr
                                                    font:[UIFont systemFontOfSize:14]
                                               textColor:RGBColor(88, 88, 88)];
    _contentLabel.internalWidth = 60;
    _contentLabel.speed = 0.5f;
    [self addSubview:_contentLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _anounceImage.frame = CGRM(12, 12, 27, 16);
    _contentLabel.frame = CGRM(CGRectGetMaxX(_anounceImage.frame)+10, 12, 300, 16);
    
    CGFloat btnWidth = self.width - 60;
    CGFloat btnHeight = 70;
    for(NSInteger i = 0; i < _titles.count; i++){
        UIButton* btn = [self viewWithTag:i + 10];
        btn.frame = CGRM(30, CGRectGetMaxY(_contentLabel.frame)+20*(i+1)+btnHeight*i, btnWidth, btnHeight);
    }
}
@end
