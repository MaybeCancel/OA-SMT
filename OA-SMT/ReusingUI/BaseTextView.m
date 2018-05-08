//
//  BaseTextView.m
//  OA-SMT
//
//  Created by Slark on 2018/2/28.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "BaseTextView.h"

@implementation BaseTextView{
    UITextView* _textView;
    UILabel* _topLabel;
    UIView* _lineView;
}

- (void)setUp{
    self.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc]init];
    [self addSubview:label];
    _topLabel = label;
    
    UITextView* textView = [[UITextView alloc]init];
    textView.textColor = RGBColor(204, 204, 204);
    textView.font = [UIFont systemFontOfSize:16];
    [self addSubview:textView];
    textView.delegate = self;
    _textView = textView;
    
    UIView* view = [[UIView alloc]init];
    _lineView  = view;
    view.backgroundColor = RGBColor(231, 231, 231);
    [self addSubview:view];
    
}

- (void)setTopString:(NSString *)topString{
    [self setUp];
    _topString = topString;
    _topLabel.text = _topString;
}
- (void)setPlaceholderString:(NSString *)placeholderString{
    _placeholderString = placeholderString;
    _textView.text = _placeholderString;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:self.placeholderString]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _topLabel.frame = RR(15, 15, 200, 15);
    _textView.frame = RR(15, CGRectGetMaxY(_topLabel.frame)+15, ScreenWidth - 24, 90);
    _lineView.frame = RR(15, CGRectGetMaxY(_textView.frame) + 5, ScreenWidth - 12, 1);
}

@end
