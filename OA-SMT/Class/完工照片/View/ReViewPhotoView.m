//
//  ReViewPhotoView.m
//  预览照片Demo
//
//  Created by shenliping on 16/11/14.
//  Copyright © 2016年 shenliping. All rights reserved.
//

#import "ReViewPhotoView.h"

@interface ReViewPhotoView ()
@end

@implementation ReViewPhotoView

- (instancetype)initWithFrame:(CGRect)frame Photo:(UIImage *)photo {
    if (self = [super initWithFrame:frame]) {
        CGFloat scale = photo.size.width / self.frame.size.width;
        CGFloat height = photo.size.height / scale;
        
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - height)/2, self.frame.size.width, height)];
        imageView.image = photo;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        UITapGestureRecognizer *oneTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDisappear)];
        oneTapGesture.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:oneTapGesture];
    }
    return self;
}

- (void)tapDisappear {
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
