//
//  NHCustomSegmentView.m
//  NeiHan
//
//  Created by Charles on 16/8/30.
//  Copyright © 2016年 Charles. All rights reserved.
//

#import "NHCustomSegmentView.h"
#import "UIView+Layer.h"

@implementation NHCustomSegmentView {
    NSArray *_itemTitles;
    UIButton *_selectedBtn;
}

- (instancetype)initWithItemTitles:(NSArray *)itemTitles {
    if (self = [super init]) {
        _itemTitles = itemTitles;
        self.layerCornerRadius = 8.0;
        self.layerBorderColor = RGBColor(108, 157, 235);
        self.layerBorderWidth = 1.0;
        [self setUpViews];
    }
    return self;
}
- (void)setUpViews {
    if (_itemTitles.count > 0) {
        NSInteger i = 0;
        for (id obj in _itemTitles) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *objStr = (NSString *)obj;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:btn];
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitle:objStr forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [btn setTitleColor:RGBColor(86, 138, 234) forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:16];
                i = i + 1;
                btn.tag = i;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.adjustsImageWhenDisabled = NO;
                btn.adjustsImageWhenHighlighted = NO;
            }
        }
    }
}
- (void)btnClick:(UIButton *)btn {
    _selectedBtn.backgroundColor = [UIColor whiteColor];
    _selectedBtn.selected = NO;
    btn.selected = YES;
    btn.backgroundColor =  RGBColor(56, 117, 221);
    _selectedBtn = btn;
    
    NSString *title = btn.currentTitle;
    if (self.NHCustomSegmentViewBtnClickHandle) {
        self.NHCustomSegmentViewBtnClickHandle(self, title, btn.tag - 1);
    }
}

- (void)clickDefault {
    if (_itemTitles.count == 0) {
        return ;
    }
    [self btnClick:(UIButton *)[self viewWithTag:1]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_itemTitles.count > 0) {
        CGFloat btnW = self.width / _itemTitles.count;
        for (int i = 0 ; i < _itemTitles.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i + 1];
            btn.frame = CGRectMake(btnW * i, 0, btnW, self.height);
        }
    }
}


@end
