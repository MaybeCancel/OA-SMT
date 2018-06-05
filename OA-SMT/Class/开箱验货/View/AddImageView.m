//
//  AddImageView.m
//  OA-SMT
//
//  Created by Slark on 2018/3/1.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "AddImageView.h"
#import "DeleteBtnView.h"
@implementation AddImageView{
    UILabel* _titleLabel;
    DeleteBtnView* _adminView;
    BOOL _isAdd;
}

- (void)setUp{
    self.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc]init];
    _titleLabel = label;
    [self addSubview:_titleLabel];
   
    
    DeleteBtnView* btnView = [DeleteBtnView createBtnView];
    btnView.contenImageView.image = [UIImage imageNamed:@"btn_addImage"];
    [self addSubview:btnView];
    btnView.deleteBtnHidden = YES;
   
    btnView.contenImageView.layerBorderWidth = 1;
    btnView.contenImageView.layerBorderColor = RGBColor(223, 223, 223);
    _adminView = btnView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof(AddImageView*)weaksel = self;
    int imageCount = 5;
    CGFloat imageWidth = (SCREEN_WIDTH-15) /imageCount;
    CGFloat imageHeight = imageWidth;
//框子 58
    _titleLabel.frame = CGRM(15, 15, 100, 15);
    if (self.images.count== 0||!self.images) {
        _adminView.frame = CGRM(3, CGRectGetMaxY(_titleLabel.frame)+2, imageWidth, imageHeight);

        [_adminView addTapActionWithBlock:^{
            NSLog(@"添加照片回调");
            if (weaksel.tapHandle) {
                weaksel.tapHandle();
            }
        }];
    }else{
        for (NSInteger i = 0; i < self.images.count; i ++) {
            DeleteBtnView* imageView = [self viewWithTag:i + 10];
            imageView.frame = CGRM(3 + (imageWidth+3)*(i%imageCount),CGRectGetMaxY(_titleLabel.frame)+2  + (imageWidth+3)*(i/imageCount), imageWidth, imageHeight);
            if(i == self.images.count - 1){
                imageView.contenImageView.layerBorderWidth = 1;
                imageView.contenImageView.layerBorderColor = RGBColor(223, 223, 223);
            }
        }
    }
    
}
- (void)setImages:(NSMutableArray *)images{
    _images = images;
    [self reloadImageView];
}
- (void)setTitle:(NSString *)title{
    [self setUp];
    _title = title;
    _titleLabel.text = _title;
}

- (void)reloadImageView{
    //刷新图片 清楚上一次添加视图
    for (id objc in self.subviews) {
        if ([objc isKindOfClass:[DeleteBtnView class]]) {
            [(DeleteBtnView*)objc removeFromSuperview];
        }
    }
    if (!_isAdd) {
        [self.images addObject:[UIImage imageNamed:@"btn_addImage"]];
    }
     _isAdd = YES;
    if (self.images.count > 2) {
         [self.images exchangeObjectAtIndex:self.images.count-1 withObjectAtIndex:self.images.count-2];
    }
    for (int i = 0; i < self.images.count; i++) {
        DeleteBtnView* btnView = [DeleteBtnView createBtnView];
        btnView.contenImageView.image = self.images[i];
        btnView.tag = i + 10;
        [self addSubview:btnView];
        kWeakSelf(weakSelf);
        btnView.deleteBtnAction = ^{
            if (weakSelf.deleteImageBlock) {
                weakSelf.deleteImageBlock(i);
            }
        };
        
        if (i == self.images.count-1) {
            _adminView = btnView;
            _adminView.deleteBtnHidden = YES;
            
            [_adminView addTapActionWithBlock:^{
                NSLog(@"添加照片回调");
                if (weakSelf.tapHandle) {
                    weakSelf.tapHandle();
                }
            }];
        }
       
    }
}

@end
