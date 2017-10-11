//
//  ERDeviceMessage.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERDeviceMessage : NSObject

/**
 *  设备剩余存储空间
 *
 *  @return 剩余存储空间
 */
+ (NSString *)freeDiskSpaceInBytes;
@end
