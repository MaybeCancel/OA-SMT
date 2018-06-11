//
//  NSString+MD5Addition.h
//  悦动
//
//  Created by 岑臣 on 15/12/22.
//  Copyright © 2015年 岑臣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Addition)
- (NSString *)md5HexDigest;
- (NSString *)md5HexDigestUpper;
@end
