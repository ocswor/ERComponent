//
//  ERCirclePicView.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/11.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERCircleModelProtocol.h"

typedef void(^LoadImageBlock)(UIImageView *imageView,NSURL *url);

@protocol ERCirclePicViewDelegate <NSObject>

-(void)circlePicViewDidScrollPicModel:(id<ERCircleModelProtocol>)picModel;

@end

@interface ERCirclePicView : UIView

+(instancetype)initWithFrame:(CGRect)frame PicModels:(NSArray <id <ERCircleModelProtocol>>*)picModels LoadImageBlock:(LoadImageBlock)loadBlock;

/**
 *  用于告知外界, 当前滚动到的是哪个广告数据模型
 */
@property (nonatomic, strong) id<ERCirclePicViewDelegate> delegate;


@end
