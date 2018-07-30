//
//  UIImage+ZipSize.m
//  悦动
//
//  Created by Maybe_文仔 on 2018/4/8.
//  Copyright © 2018年 岑臣. All rights reserved.
//

#import "UIImage+ZipSize.h"

@implementation UIImage (ZipSize)
- (NSData *)compressMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(self, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}
@end
