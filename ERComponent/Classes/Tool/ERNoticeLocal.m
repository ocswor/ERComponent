//
//  ERNoticeLocal.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "ERNoticeLocal.h"

@implementation ERNoticeLocal
    
    
+(UILocalNotification*)RegisterLocalNotificationWithFireDate:(NSDate *)firedate //后台运行的本地通知
                                                  repeatType:(NSCalendarUnit)repeatInterval keepSleep:(BOOL)isKeepSleep;
    {
        
        
        UILocalNotification *localNoti = [[UILocalNotification alloc] init];
        localNoti.repeatInterval = repeatInterval;
        localNoti.timeZone = [NSTimeZone systemTimeZone];
        localNoti.fireDate = firedate;
        localNoti.alertAction = @"查看";
        localNoti.alertBody = @"该起床啦";
        localNoti.soundName = UILocalNotificationDefaultSoundName;
        NSDictionary *dict = nil;
        
        if (isKeepSleep) {
            [self cancelKeepSleepNotice];
            dict =   @{@"noticekeepSleepID" : @"noticekeepSleep"};
        }else {
            [self cancleAlarmNotifications];
            dict =   @{@"noticeAlarmID" : @"noticeAlarm"};
            
        }
        localNoti.userInfo = dict;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
        NSLog(@"\n=============Normal注册通知============\n%@\n",localNoti);
        return localNoti;
    }
    
+(void)cancelAllLocalNotifications{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
    
+(void)cancelKeepSleepNotice{
    
    int i = 0;
    
    for (UILocalNotification *ln in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        
        NSLog(@"cancelKeepSleepNotice = ln.userInfo = %@",ln.userInfo);
        if ([[ln.userInfo objectForKey:@"noticekeepSleepID"] isEqualToString:@"noticekeepSleep"]) {
            [[UIApplication sharedApplication] cancelLocalNotification:ln];
            NSLog(@"\n=============删除通知============\n%@\n",ln);
            i++;
        }
    }
    
}
    
+(void)cancleAlarmNotifications{
    int i = 0;
    
    for (UILocalNotification *ln in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        
        NSLog(@"cancleAlarmNotifications = ln.userInfo = %@",ln.userInfo);
        if ([[ln.userInfo objectForKey:@"noticeAlarmID"] isEqualToString:@"noticeAlarm"]) {
            [[UIApplication sharedApplication] cancelLocalNotification:ln];
            NSLog(@"\n=============删除通知============\n%@\n",ln);
            i++;
        }
    }
}
@end
