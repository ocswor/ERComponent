//
//  ERDownLoaderTool.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/26.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "ERDownLoaderTool.h"
#import "NSString+ERDownloader.h"
#import "ERDownLoaderFileTool.h"

#define kCache NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTmp NSTemporaryDirectory() //tmp目录每次都会变化
//#define kTmp NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject ///var/mobile/Containers/Data/

@interface ERDownLoaderTool()<NSURLSessionDataDelegate>
{
    //临时文件大小
    long long _tmpFileSize;
    //文件总大小
    long long _totalFileSize;
}

@property(nonatomic,copy)NSString *cacheFilePath;
@property(nonatomic,copy)NSString *tmpFilePath;
@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,weak)NSURLSessionDataTask *task;
@property(nonatomic,strong)NSOutputStream *outputStream;


@end


@implementation ERDownLoaderTool


-(void)downloadWithURL:(NSURL *)url toPathDir:(NSString *)pathDir{
    self.cacheFilePath = [kCache stringByAppendingPathComponent:[url lastPathComponent]];
    NSString *fileDir = kTmp;
    


    BOOL isDir = YES;
    if([[NSFileManager defaultManager] fileExistsAtPath:pathDir isDirectory:&isDir]){
        fileDir = pathDir;
    }
    self.tmpFilePath = [fileDir stringByAppendingPathComponent:url.absoluteString.md5Str];
    NSLog(@"tmpFilePath %@",self.tmpFilePath);

    if ([ERDownLoaderFileTool isFileExists:self.cacheFilePath]) {
        //文件已经有下载 缓存目录下标识该文件已经现在完毕
        [ERDownLoaderFileTool fileSizeWithPath:self.cacheFilePath];
        if(self.successBlock){
            self.successBlock(self.cacheFilePath);
        }
        self.state = ERDownLoaderStateSuccess;
    }else{
        switch (self.state) {
            case ERDownLoaderStatePause:
                 [self resume];
                break;
                
            default:
                _tmpFileSize = [ERDownLoaderFileTool fileSizeWithPath:self.tmpFilePath];
                [self downloadWithURL:url offset:_tmpFileSize];
                break;
        }
        
    }

}

-(void)downLoadWithURL:(NSURL *)url downLoadInfo:(ERDownLoadInfoType)downLoadBlock success:(ERDownLoadSuccessType)successBlock failed:(ERDownLoadFailType)failBlock{
    self.downLoadInfo = downLoadBlock;
    self.successBlock = successBlock;
    self.failBlock = failBlock;
    [self downloadWithURL:url toPathDir:nil];
}

#pragma mark - 私有方法
-(void)downloadWithURL:(NSURL *)url offset:(long long)offset{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:0];
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",offset] forHTTPHeaderField:@"Range"];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    [task resume];
    self.task = task;
}

// 暂停了几次, 恢复几次, 才可以恢复
- (void)resume {
    if (self.state == ERDownLoaderStatePause) {
        [self.task resume];
        self.state = ERDownLoaderStateDowning;
    }
}

- (void)pause {
    if (self.state == ERDownLoaderStateDowning)
    {
        [self.task suspend];
        self.state = ERDownLoaderStatePause;
    }
    
}

- (void)cancel {
    [self.session invalidateAndCancel];
    self.session = nil;
    self.state = ERDownLoaderStateFailed;
}

- (void)cancelAndClearCache {
    [self cancel];
    // 删除缓存
    [ERDownLoaderFileTool removeFileAtPath:self.tmpFilePath];
}
#pragma mark - NSURLSessionDataDelegate


/**
 当发送请求第一收到响应

 @param session
 @param dataTask
 @param response
 @param completionHandler
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    _totalFileSize = [httpResponse.allHeaderFields[@"Content-Length"] longLongValue];
    if (httpResponse.allHeaderFields[@"Content-Range"]) {
        NSString *rangeStr = httpResponse.allHeaderFields[@"Content-Range"];
        _totalFileSize = [[[rangeStr componentsSeparatedByString:@"/"] lastObject] longLongValue];
    }
    
    if (self.downLoadInfo) {
        self.downLoadInfo(_totalFileSize);
    }
    if (_tmpFileSize > _totalFileSize) {
        NSLog(@"缓存有问题, 删除缓存, 重新下载");
        // 删除缓存
        [ERDownLoaderFileTool removeFileAtPath:self.tmpFilePath];
        // 取消请求
        completionHandler(NSURLSessionResponseCancel);
        // 重新发送请求  0
        [self downloadWithURL:response.URL offset:0];
        return;
        
    }
    self.state = ERDownLoaderStateDowning;
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:self.tmpFilePath append:YES];
    [self.outputStream open];
    completionHandler(NSURLSessionResponseAllow);
    
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    // 进度 = 当前下载的大小 / 总大小
    _tmpFileSize += data.length;
    self.progress = 1.0 * _tmpFileSize / _totalFileSize;
    [self.outputStream write:data.bytes maxLength:data.length];

}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    [self.outputStream close];
    self.outputStream = nil;
    
    if (error == nil) {
        NSLog(@"下载完毕");
        [ERDownLoaderFileTool moveFile:self.tmpFilePath toPath:self.cacheFilePath];
        self.state = ERDownLoaderStateSuccess;
        if (self.successBlock) {
            self.successBlock(self.cacheFilePath);
        }
    }else{
        self.state = ERDownLoaderStateFailed;
        if (self.failBlock) {
            self.failBlock();
        }
    }
}

#pragma mark - 懒加载
-(NSURLSession *)session{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}


- (void)setState:(ERDownLoaderState)state {
    if (_state == state) {
        return;
    }
    _state = state;
    
    if (self.downLoadStateChange) {
        self.downLoadStateChange(state);
    }
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    if (self.downLoadProgress) {
        self.downLoadProgress(progress);
    }
}

@end
