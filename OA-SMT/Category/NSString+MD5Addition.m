//
//  NSString+MD5Addition.m
//  悦动
//
//  Created by 岑臣 on 15/12/22.
//  Copyright © 2015年 岑臣. All rights reserved.
//

#import "NSString+MD5Addition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Addition)

-(NSString *)md5HexDigest{
    uint8_t  result[CC_MD5_DIGEST_LENGTH];
    
    const char *original_str = [self UTF8String];
    CC_MD5( original_str, (CC_LONG)strlen(original_str), result );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ] ;
}

- (NSString*)md5HexDigestUpper{
    return [[self md5HexDigest] uppercaseString];
}

@end
