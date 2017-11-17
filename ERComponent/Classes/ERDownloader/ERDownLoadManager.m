//
//  ERDownLoadManger.m
//  ERComponent_Example
//
//  Created by eric on 2017/11/17.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "ERDownLoadManager.h"
#import "ERDownLoaderTool.h"
#import "NSString+ERDownloader.h"

@interface ERDownLoadManager()

@property(nonatomic,strong)NSMutableDictionary<NSString *,ERDownLoaderTool *>*downLoadInfo;

@end

@implementation ERDownLoadManager

static ERDownLoadManager *_shareInstance;
+(instancetype)shareInstance{
    if (!_shareInstance) {
        _shareInstance = [[ERDownLoadManager alloc] init];
    }
    return _shareInstance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (!_shareInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}

-(NSMutableDictionary *)downLoadInfo{
    if (!_downLoadInfo) {
        _downLoadInfo = [NSMutableDictionary dictionary];
    }
    return _downLoadInfo;
}

-(void)downLoadWithURL:(NSURL *)url withSuccess:(ERDownLoadSuccessType)successBlock failed:(ERDownLoadFailType)failedBlock{
    NSString *md5 = [url.absoluteString md5Str];
    ERDownLoaderTool *downLoader = self.downLoadInfo[md5];
    if (downLoader) {
        [downLoader resume];
        return;
    }
    downLoader = [[ERDownLoaderTool alloc] init];
    [self.downLoadInfo setValue:downLoader forKey:md5];
    
    
    __weak typeof(self) weakSelf = self;
    [downLoader downLoadWithURL:url downLoadInfo:^(long long fileSize) {
        
    } success:^(NSString *cacheFilePath) {
        [weakSelf.downLoadInfo removeObjectForKey:md5];
        if(successBlock) {
            successBlock(cacheFilePath);
        }
    } failed:^{
        [weakSelf.downLoadInfo removeObjectForKey:md5];
        if (failedBlock) {
            failedBlock();
        }
    }];
}


-(ERDownLoaderTool *)downLoadWithURL:(NSURL *)url{
    
    NSString *md5 = [url.absoluteString md5Str];
    ERDownLoaderTool *downLoader = self.downLoadInfo[md5];
    if (downLoader) {
        [downLoader resume];
        return downLoader;
    }
    downLoader = [[ERDownLoaderTool alloc]init];
    [self.downLoadInfo setValue:downLoader forKey:md5];
    __weak typeof(self) weakSelf = self;
    [downLoader downLoadWithURL:url downLoadInfo:^(long long fileSize) {
    } success:^(NSString *cacheFilePath) {
        [weakSelf.downLoadInfo removeObjectForKey:md5];
    } failed:^{
        [weakSelf.downLoadInfo removeObjectForKey:md5];
    }];
    return downLoader;
    
}

-(void)pauseWithURL:(NSURL *)url{
    NSString *md5 = [url.absoluteString md5Str];
    ERDownLoaderTool *downLoader = self.downLoadInfo[md5];
    [downLoader pause];
}

- (void)cancelWithURL: (NSURL *)url {
    NSString *md5 = [url.absoluteString md5Str];
    ERDownLoaderTool *downLoader = self.downLoadInfo[md5];
    [downLoader cancel];
}

- (void)pauseAll {
    [[self.downLoadInfo allValues] makeObjectsPerformSelector:@selector(pause)];
}

@end
