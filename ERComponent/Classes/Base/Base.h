//
//  Base.h
//  Game
//
//  Created by 扆佳梁 on 16/8/17.
//  Copyright © 2016年 Eric. All rights reserved.

#ifndef Base_h
#define Base_h



// 如果是调试模式(DEBUG 是调试模式下, 自带的宏)
#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__);
// 打印调用函数的宏
#define LOG_METHOD NSLog(@"%s", __func__);
#define LOG_METHOD_EXT(fmt, ...) NSLog((@"%s" fmt), __func__, __VA_ARGS__);
#else
#define LOG(...);
#define LOG_METHOD ;
#define LOG_METHOD_EXT(fmt, ...);
#endif




// 随机颜色
#define ERColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ERRandomColor XMGColor(arc4random_uniform(255.0), arc4random_uniform(255.0), arc4random_uniform(255.0))


// 屏幕尺寸相关
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

// 弱引用
#define kWeakSelf __weak typeof(self) weakSelf = self;

// 设置默认字体大小
#define DefaultFontWithSize(s) [UIFont fontWithName:@"HelveticaNeue-Light" size:s]


// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]


//** 沙盒路径 ***********************************************************************************

/* 应用程序目录的路径，在该目录下有三个文件夹：Documents、Library、temp
/Library/。该路径下一般保存着用户配置文件。可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份。*/

#define PATH_OF_APP_HOME    NSHomeDirectory()
//保存临时文件 temp 目录
#define PATH_OF_TEMP        NSTemporaryDirectory()

// Documents 目录
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#endif /* Base_h */
