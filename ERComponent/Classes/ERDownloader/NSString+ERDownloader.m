//
//  NSString+ERDownloader.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/26.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "NSString+ERDownloader.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ERDownloader)

-(NSString *)md5Str{
    
    const char *data = self.UTF8String;
    unsigned char disgest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data, (CC_LONG)strlen(data), disgest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i =0; i<CC_MD5_DIGEST_LENGTH; i++) {
        
        [result appendFormat:@"%02x",disgest[i]];
    }
    return result;
}
@end
