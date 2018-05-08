//
//  TextViewCell.m
//  OA-SMT
//
//  Created by Slark on 2018/3/16.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
    self.textView.textColor = RGBColor(191, 191, 191);
    
}
- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.textView.text = _placeHolder;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:self.placeHolder]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}


@end
