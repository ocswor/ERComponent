//
//  ERDownLoaderTool.h
//  ERComponent_Example
//
//  Created by eric on 2017/10/26.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ERDownLoaderStateUnKnown,
    //暂停
    ERDownLoaderStatePause,
    //正在下载
    ERDownLoaderStateDowning,
    //已经下载
    ERDownLoaderStateSuccess,
    //下载失败
    ERDownLoaderStateFailed
} ERDownLoaderState;

typedef void(^ERDownLoadSuccessType)(NSString *cacheFilePath);
typedef void(^ERDownLoadFailType)(void);
typedef void(^ERDownLoadInfoType)(long long fileSize);

@interface ERDownLoaderTool : NSObject
@property(nonatomic,assign)float progress;
@property(nonatomic,strong)void(^downLoadProgress)(float progress);

//下载状态
@property(nonatomic,assign)ERDownLoaderState state;
//下载成功通知
@property(nonatomic,strong)ERDownLoadSuccessType successBlock;
//下载失败 通知
@property(nonatomic,strong)ERDownLoadFailType failBlock;
// 状态的改变 ()
// 文件下载信息 (下载的大小)
@property (nonatomic, copy) ERDownLoadInfoType downLoadInfo;

@property (nonatomic, copy) void(^downLoadStateChange)(ERDownLoaderState state);

-(void)downloadWithURL:(NSURL *)url toPathDir:(NSString *)pathDir;
- (void)downLoadWithURL: (NSURL *)url downLoadInfo: (ERDownLoadInfoType)downLoadBlock success: (ERDownLoadSuccessType)successBlock failed: (ERDownLoadFailType)failBlock;


- (void)pause;
- (void)resume;
- (void)cancel;
- (void)cancelAndClearCache;
@end
