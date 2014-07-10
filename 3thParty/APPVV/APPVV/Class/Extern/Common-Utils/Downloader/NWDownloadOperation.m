//
//  NWDownloadOperation.m
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadOperation.h"
#import "NWDownloadModel.h"
#import "NWDownloadPool.h"

@interface NWDownloadOperation () {
//    NSMutableData *responseData;
//    CGFloat totalSize;
    NWDownloadModel *downloadModel;
    
}

@end
@implementation NWDownloadOperation
+ (NSThread *)networkThread
{
    static NSThread *_networkThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkEntry:) object:nil];
        [_networkThread start];
    });
    
    return _networkThread;
}

+ (void) __attribute__((noreturn)) networkEntry:(id)__unused object
{
    do {
        @autoreleasepool
        {
            [[NSRunLoop currentRunLoop] run];
        }
    } while (YES);
}
#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------
-(id)initWith:(NSString *)url withDelegate:(id<NWDownloaderDelegate>)delegate withToken:(NSString *)token
{
    self = [super init];
    if (self) {
//        totalSize = 0;
        self.token = token;
        self.downloadURL = url;
        self.downloadDelegate = delegate;
        downloadModel = [[NWDownloadPool defaultDownloader] getDownloadModel:token];
    }
    return self;
}
#pragma mark - --------------------System--------------------
-(void)main
{
    [self performSelector:@selector(operationDidStart) onThread:[[self class] networkThread] withObject:nil waitUntilDone:NO];
}
#pragma mark - --------------------功能函数--------------------

- (void)operationDidStart
{
//    responseData = [[NSMutableData alloc] initWithLength:0];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.downloadURL]];
    NSURLConnection *urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [urlConnection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [urlConnection start];
}

- (void)handleData:(NSData *)handleData
{
    if (self.isCancelled ){
        [self cancelOperation];
        return ;
    }
    downloadModel.isDownloaded = YES;
    downloadModel.isDownloading = NO;
    downloadModel.isStop = NO;
    downloadModel.downloadedSize = downloadModel.totalSize;
    [[NWDownloadPool defaultDownloader]downloadFinished:self.token withData:nil];
}

- (void)cancelOperation{
    downloadModel.isStop = YES;
    downloadModel.isDownloaded = NO;
    downloadModel.isDownloading = NO;
    [self operationDidFinish];
}

#pragma mark - --------------------手势事件--------------------
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------

#pragma mark - NSURLConnection代理
// 收到响应时, 会触发
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse{
    if (self.isCancelled){
        [self cancelOperation];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        return ;
    }
    CGFloat totalSize = (CGFloat)aResponse.expectedContentLength;
    downloadModel.totalSize = totalSize;
}

- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data{
    if (self.isCancelled){
        [self cancelOperation];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        return ;
    }
    [downloadModel.downloadData appendData:data];
    CGFloat currentSize = downloadModel.downloadData.length;
    downloadModel.downloadedSize = currentSize;
    NSLog(@"%lf",currentSize/downloadModel.totalSize);
    if (self.downloadDelegate && [self.downloadDelegate respondsToSelector:@selector(downloadProgress:withToken:)]) {
        [self.downloadDelegate downloadProgress:currentSize/downloadModel.totalSize withToken:self.token];
    }
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (self.isCancelled){
        [self cancelOperation];
        return ;
    }
    [self operationDidFinish];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConn{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (self.isCancelled) {
        [self cancelOperation];
        return ;
    } else {
        [self handleData:downloadModel.downloadData];
    }
    [self operationDidFinish];
}

#pragma mark - --------------------属性相关--------------------

- (void)operationDidFinish
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

#pragma mark - --------------------接口API--------------------
@end
