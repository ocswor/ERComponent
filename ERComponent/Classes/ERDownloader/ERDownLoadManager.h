//
//  ERDownLoadManger.h
//  ERComponent_Example
//
//  Created by eric on 2017/11/17.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ERDownLoaderTool.h"


@interface ERDownLoadManager : NSObject

+(instancetype)shareInstance;
-(ERDownLoaderTool *)downLoadWithURL:(NSURL *)url;

-(void)downLoadWithURL:(NSURL *)url withSuccess:(ERDownLoadSuccessType)successBlock failed:(ERDownLoadFailType)failedBlock;

-(void)pauseWithURL:(NSURL *)url;
-(void)cancelWithURL:(NSURL *)url;
-(void)pauseAll;
@end
