//
//  UIImageView+Extension.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Extension.h"

@interface UIImageView (Extension)
- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage progress:(void(^)(CGFloat progress))progress complete: (void(^)())complete;
- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle;
@end
