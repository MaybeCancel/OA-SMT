//
//  ObjectInfoView.m
//  OA-SMT
//
//  Created by Slark on 2018/3/12.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "ObjectInfoView.h"

@implementation ObjectInfoView
- (void)setModels:(NSMutableArray *)models{
    _models = models;
    [self setUp];
}

- (void)setUp{
    UIColor* lineColor = RGBColor(220, 220, 220);
    //循环数量
    //横向线条
    for (NSInteger j = 0 ; j < 7; j ++) {
        if (j == 6) {
            //最后一次 封口线条
            UIView* lastView = [[UIView alloc]init];
            lastView.backgroundColor = lineColor;
            lastView.tag = j + 100;
            [self addSubview:lastView];
        }else{
            UIView* lineView = [[UIView alloc]init];
            lineView.backgroundColor = lineColor;
            lineView.tag = j + 100;
            [self addSubview:lineView];
        }
    }
    //竖向线条
    for (NSInteger k = 0; k < 10; k ++) {
        if (k == 9) {
            UIView* lineView = [[UIView alloc]init];
            lineView.backgroundColor = lineColor;
            lineView.tag = k + 1000;
            [self addSubview:lineView];
        }else{
            UIView* lineView1 = [[UIView alloc]init];
            lineView1.backgroundColor = lineColor;
            lineView1.tag = k+ 1000;
            [self addSubview:lineView1];
        }
    }
    //一个Model
    for (NSInteger i = 0; i < 54; i ++) {
        UILabel* label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"666";
        label.tag = i + 10;
        label.textColor = RGBColor(56, 56, 56);
        [self addSubview:label];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //横向线条
    for(NSInteger i = 0; i < 7; i++){
        UIView* view = [self viewWithTag:i + 100];
        view.frame = RR(0, 0+(44*i), 73*9, 1);
    }
    //竖向线条
    for(NSInteger i = 0; i < 10; i++){
        UIView* view = [self viewWithTag:i + 1000];
        view.frame = RR(0+73*i, 0, 1, 44*6);
    }
//    //内容
    for(NSInteger i = 0; i < 54; i++){
        UILabel* label = [self viewWithTag:i + 10];
        label.frame = RR(73*(i%9), 44*(i/9), 73, 44);
        if(i/9%2 == 0){
            label.backgroundColor = RGBColor(246, 246, 246);
        }else if (i/9%2 != 0 ){
             label.backgroundColor = RGBColor(230, 230, 230);
        }
    }
   
    
}
@end
