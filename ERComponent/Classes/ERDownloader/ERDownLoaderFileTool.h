//
//  ERDownLoaderFileTool.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/26.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERDownLoaderFileTool : NSObject

+(BOOL)isFileExists:(NSString *)path;

+(long long)fileSizeWithPath:(NSString *)path;

+(void)moveFile:(NSString *)fromPath toPath:(NSString *)toPath;

+(void)removeFileAtPath:(NSString *)path;


@end
