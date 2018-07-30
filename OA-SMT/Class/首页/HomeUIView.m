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
    NSArray*_images;
    UIImageView* _anounceImage;
    YFRollingLabel* _contentLabel;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles AndImages:(NSArray<NSString *> *)images{
    self = [super init];
    if (self) {
        _titles = titles;
        _images = images;
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
    
    
    if (_titles.count != _images.count||_titles.count < 1||_images.count < 1) {
        return;
    }
    for(NSInteger i = 0; i < _titles.count; i++){
        HomeBtnView* btnView = [[HomeBtnView alloc]initWithTitle:_titles[i] AndImageName:_images[i]];
        [self addSubview:btnView];
        btnView.tag = i + 10;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDown:)];
        [btnView addGestureRecognizer:tap];
    }
}
- (void)tapDown:(UITapGestureRecognizer*)tap{
    //获取点击tag
    HomeBtnView* homeView = (HomeBtnView*)tap.view;
    [homeView ViewToBig];
    if(self.pageViewHandle){
        self.pageViewHandle(homeView.tag);
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
    
    CGFloat btnWidth = (self.width - 2) / 3;
    CGFloat btnHeight = (self.height - 4-40) / 4;
    for(NSInteger i = 0; i < _titles.count; i++){
        HomeBtnView* btnView = [self viewWithTag:i + 10];
        btnView.frame = CGRM(0 + (btnWidth + 1) * (i%3), 40 + (btnHeight + 1) * (i/3), btnWidth, btnHeight);
    }
}
@end
