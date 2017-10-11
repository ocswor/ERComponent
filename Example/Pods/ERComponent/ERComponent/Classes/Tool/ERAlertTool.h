//
//  ERAlertTool.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERAlertTool : NSObject
+ (void)alertTitle:(NSString *)titile type:(UIAlertControllerStyle)alertType message:(NSString *)message didTask:(void(^)())task;
@end
