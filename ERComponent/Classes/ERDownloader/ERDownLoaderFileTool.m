//
//  ERDownLoaderFileTool.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/26.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "ERDownLoaderFileTool.h"

@implementation ERDownLoaderFileTool

+(BOOL)isFileExists:(NSString *)path{
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
    
}

+(long long)fileSizeWithPath:(NSString *)path{
    
    if (![self isFileExists:path]) {
        return 0;
    }
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    long long size = [fileInfo[NSFileSize] longLongValue];
    
    return size;
}

+(void)moveFile:(NSString *)fromPath toPath:(NSString *)toPath{
    if (![self isFileExists:fromPath]) {
        return;
    }
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
}

+(void)removeFileAtPath:(NSString *)path{
    if (![self isFileExists:path]) {
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}
@end
