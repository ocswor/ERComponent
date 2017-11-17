//
//  ERCircleModelProtocol.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/11.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//


@protocol ERCircleModelProtocol <NSObject>

/**
 *  图片URL
 */
@property (nonatomic, copy) NSURL *ERImgURL;

/**
 *  点击执行的代码块(优先级高于adLinkURL)
 */
@property (nonatomic, copy) void(^clickBlock)(void);
@end
