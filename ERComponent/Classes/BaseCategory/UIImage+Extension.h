//
//  UIImage+Extention.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)


/**
 修改渲染模式,使用原图渲染

 @param name 图片名字
 @return 图片
 */
+ (UIImage *)originImageWithName: (NSString *)name;

    

/**
 对图片 转换圆形
 在CGContextRef 上剪切一个园,再在上下文下重绘

 @return 圆图
 */
- (UIImage *)circleImage;
@end
