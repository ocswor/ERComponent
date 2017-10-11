//
//  ERAlertTool.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "ERAlertTool.h"

@implementation ERAlertTool

    
+ (void)alertTitle:(NSString *)titile type:(UIAlertControllerStyle)alertType message:(NSString *)message didTask:(void(^)())task {
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:alertType];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (task) {
            task();
        }
    }];
    
    [alertVC addAction:action];
    [alertVC addAction:action1];
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}
@end
