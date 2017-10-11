//
//  UIImageView+Extension.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/10.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Extension)

- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage progress:(void(^)(CGFloat progress))progress complete: (void(^)())complete; {
    
    [self sd_setImageWithURL:url placeholderImage:placeHoldImage options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (progress != nil)
        {
            progress(1.0 * receivedSize / expectedSize);
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.image = image;
        if (complete != nil)
        {
            complete();
        }
    }];
    
    
    
}
    
- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle {
    
    if (isCircle) {
        [self sd_setImageWithURL:url placeholderImage:[placeHoldImage circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            
            UIImage *resultImage = [image circleImage];
            
            // 6. 处理结果图片
            if (resultImage == nil) return;
            self.image = resultImage;
            
            
        }];
        
    }else {
        [self sd_setImageWithURL:url placeholderImage:placeHoldImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // 6. 处理结果图片
            if (image == nil) return;
            self.image = image;
            
            
        }];
        
    }
    
    
}
@end
