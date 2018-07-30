//
//  UIImage+ZipSize.h
//  悦动
//
//  Created by Maybe_文仔 on 2018/4/8.
//  Copyright © 2018年 岑臣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZipSize)
- (NSData *)compressMaxDataSizeKBytes:(CGFloat)size;
@end
