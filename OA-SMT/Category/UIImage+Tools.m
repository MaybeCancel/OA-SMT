//
//  UIImage+Tools.m
//  OA-SMT
//
//  Created by Slark on 2018/1/15.
//  Copyright © 2018年 Slark. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)
+ (UIImage*) imageWithUIView:(UIView*) view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:context];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
}

+ (UIImage *)addWatemarkImageWithLogoImage:(UIImage *)logoImage watemarkImage:(UIImage *)watemarkImage logoImageRect:(CGRect)logoImageRect watemarkImageRect:(CGRect)watemarkImageRect{
    // 创建一个graphics context来画我们的东西
    UIGraphicsBeginImageContext(logoImageRect.size);
    // graphics context就像一张能让我们画上任何东西的纸。我们要做的第一件事就是把person画上去
    [logoImage drawInRect:CGRectMake(0, 0, logoImageRect.size.width, logoImageRect.size.height)];
    // 然后在把hat画在合适的位置
    [watemarkImage drawInRect:CGRectMake(watemarkImageRect.origin.x, watemarkImageRect.origin.y, watemarkImageRect.size.width, watemarkImageRect.size.height)];
    // 通过下面的语句创建新的UIImage
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 最后，我们必须得清理并关闭这个再也不需要的context
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)waterMarkImage:(UIImage *)image withText:(NSString *)text withFrame:(CGRect)rect{
    UIGraphicsBeginImageContext(image.size);
    //在画布中绘制内容
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
 
    //绘制文字
    [[UIColor darkGrayColor] set];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:30]};
    [text drawInRect:rect withAttributes:dic];
    //从画布中得到image
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}


@end
