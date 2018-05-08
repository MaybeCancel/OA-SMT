//
//  BaseCellView.m
//  Abroad-agent
//
//  Created by Slark on 17/6/15.
//  Copyright © 2017年 Slark. All rights reserved.
//

#import "BaseCellView.h"

@implementation BaseCellView{
    UILabel* _leftLabel;
    UILabel* _rightLabel;
    UIImageView* _arrowImageView;
    UIView* _lineView;
    
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    self.backgroundColor = [UIColor whiteColor];
    UILabel* leftLabel = [[UILabel alloc]init];
    _leftLabel = leftLabel;
    [self addSubview:leftLabel];
    
    UILabel* rightLabel = [[UILabel alloc]init];
    rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel = rightLabel;
    [self addSubview:rightLabel];
   
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_list"]];
    _arrowImageView =imageView;
    [self addSubview:imageView];
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = RGBColor(248, 248, 248);
    [self addSubview:_lineView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDown)];
    [self addGestureRecognizer:tap];
}
- (void)tapDown{
    if (self.TapHandle) {
        self.TapHandle();
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _leftLabel.frame = CGRectMake(15, 16, 120, 13);
    _rightLabel.frame = CGRectMake(self.width - CCWidth(36) - 100, 13, 100, 20);
    _arrowImageView.frame = CGRectMake(self.width-15-8, 16, 7, 12);
    _lineView.frame = RR(12, self.height-1, self.width, 1);
    _rightLabel.numberOfLines = 0;
}
- (void)setLeftString:(NSString *)leftString{
    _leftString = leftString;
    _leftLabel.text = _leftString;
}
- (void)setRightString:(NSString *)rightString{
    _rightString = rightString;
    _rightLabel.text = _rightString;
}
- (void)setTextColor:(UIColor *)TextColor{
    _TextColor = TextColor;
    _rightLabel.textColor = _TextColor;
}
- (void)setArrowHidden:(BOOL)arrowHidden{
    _arrowHidden = arrowHidden;
    _arrowImageView.hidden = _arrowHidden;
}
- (void)setRightFont:(NSInteger)rightFont{
    _rightFont = rightFont;
    _rightLabel.font = [UIFont systemFontOfSize:rightFont];
}
@end
