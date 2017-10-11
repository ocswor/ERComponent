//
//  ERDeviceMessage.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "ERDeviceMessage.h"
#include <sys/param.h>
#include <sys/mount.h>

@implementation ERDeviceMessage


+ (NSString *)freeDiskSpaceInBytes {
    struct statfs buf;
    float freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    
    // 处理单位
    NSArray *units = @[@"B", @"KB", @"MB", @"GB", @"TB"];
    NSInteger count = 1000;
    NSInteger index = 0;
    while (freespace > count) {
        freespace = freespace / count;
        index ++;
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%.1f%@", freespace, units[index]];
    
    return formatStr;
}
@end
