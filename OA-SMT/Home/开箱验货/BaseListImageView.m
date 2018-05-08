//
//  BaseListImageView.m
//  OA-SMT
//
//  Created by Slark on 2018/3/6.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseListImageView.h"

@implementation BaseListImageView{
    UILabel* _topLabel;
    UIButton* _btn;

}

- (instancetype)init{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)setImages:(NSMutableArray *)images{
    _images = images;
    [self setUp];
}

- (void)setUp{
    _topLabel = [[UILabel alloc]init];
    [self addSubview:_topLabel];

    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"123123" forState:UIControlStateNormal];
    [self addSubview:_btn];
    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    for (NSInteger i = 0; i < _images.count; i++) {
        UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_images[i]]];
        [self addSubview:imageView];
        imageView.tag = i + 10;
    }
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _topLabel.frame = RR(15, 15, 200, 15);
    _btn.frame = RR(15, CGRectGetMaxY(_topLabel.frame)+15, 200, 15);
    for (NSInteger i = 0; i < _images.count; i ++) {
        UIImageView* imageView = [self viewWithTag:i + 10];
        imageView.frame = RR(15, CGRectGetMaxY(_btn.frame)+ 15+(230+15) * i,ScreenWidth - 30 , 230);
    }
}


- (void)setTopString:(NSString *)topString{
    _topString = topString;
    _topLabel.text = topString;
}
- (void)setBtnTitle:(NSString *)btnTitle{
    _btnTitle = btnTitle;
    [_btn setTitle:_btnTitle forState:UIControlStateNormal];
    [_btn setTitleColor:RGBColor(63, 123, 232) forState:UIControlStateNormal];
    _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}
- (void)btnClick{
    if (self.btnClickAction) {
        self.btnClickAction();
    }
}
@end
