//
//  HomeBtnView.m
//  OA-SMT
//
//  Created by Slark on 2017/12/26.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "HomeBtnView.h"

@implementation HomeBtnView{
    UILabel* _titleLabel;
    UIImageView* _imageView;
}
- (instancetype)initWithTitle:(NSString *)title AndImageName:(NSString *)name{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:name];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
    }
    return self;
}

- (void)ViewToBig{
    [UIView animateWithDuration:0.3 animations:^{
         self.transform = CGAffineTransformMakeScale(0.95, 0.95);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
             self.transform = CGAffineTransformIdentity;
        }];
    }];
}
- (void)ViewToIdenty{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = CGRM(AutoScaleWidth(29), AutoScaleHeight(33), self.width-AutoScaleWidth(29)*2, AutoScaleHeight(54));
    _titleLabel.frame = CGRM(0, CGRectGetMaxY(_imageView.frame) + 8, self.width , AutoScaleWidth(12));
}


@end
