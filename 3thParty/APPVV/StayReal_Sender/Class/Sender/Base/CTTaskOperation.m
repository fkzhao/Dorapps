//
//  CTTaskOperation.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-6.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTTaskOperation.h"
#import "CTServiceResultQueue.h"
#import "CTSenderManager.h"
#import "CTViewCacheManage.h"
#import "CTViewCacheBean.h"

@interface CTTaskOperation()

/* 当前操作的urlstring**/
@property (strong,nonatomic) NSString *urlString;
/** 递归锁*/
@property(nonatomic, readwrite, strong) NSRecursiveLock *lock;
@end


@implementation CTTaskOperation

#pragma mark - --------------------退出清空--------------------

-(void)dealloc{
}
#pragma mark - --------------------初始化--------------------

-(id)init
{
    self = [super init];
    if (self) {
        self.token = @"";
        self.lock = [[NSRecursiveLock alloc]init];
        self.lock.name = @"com.stayreal.task.lock";
        self.callBack = [[CTSenderCallBack alloc]init];
        self.cancelTask = NO;
    }
    return self;
}
/**
 根据token初始化对象
 
 @param	token	当前对象的token
 
 @return 返回当前对象的实例
 */
-(id)initWithToken:(NSString *)token  callBack:(CTSenderCallBack *)callBack{
    self = [super init];
    if (self) {
        self.token = token;
        self.lock = [[NSRecursiveLock alloc]init];
        self.lock.name = @"com.stayreal.task.lock";
        self.callBack = callBack;
        self.cancelTask = NO;
    }
    return self;
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

#pragma mark - --------------------System--------------------

/**
 	需要操作的任务在这个地方
 */
-(void)main
{
    [self.lock lock];
    if ([self isCancelled])
    {
        return;
    }
    [self performSelector:@selector(operationDidStart) onThread:[[self class] networkThread] withObject:nil waitUntilDone:NO];
    [self.lock unlock];
}

#pragma mark - --------------------功能函数--------------------
- (void)operationDidStart
{
    [self.lock lock];
    CTMutableURLRequest *request = nil;
    if (self.requestModel.HTTPMethod == eHTTPREQUEST_METHOD_GET) {
        [request setHTTPMethod:@"GET"];
        [self.requestModel assemblyParameters];
        request = [CTMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestModel.url]];
    } else if (self.requestModel.HTTPMethod == eHTTPREQEUSET_METHOD_POST){
        request = [CTMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestModel.url]];
        [request setHTTPMethod:@"POST"];
        [self.requestModel assemblyParameters];
        NSData *data = [self.requestModel.HTTPBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
    }
    request.timeoutInterval = 60;//60秒超时
    responseData = [[NSMutableData alloc] initWithLength:0];
    self.connection = [[CTURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.connection.token = self.token;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.connection start];
    [self.lock unlock];
}
- (void)cancelOperation{
    CTServiceResultQueue *result = [CTSenderManager getServiceReslutQueue:self.token];
    CTServiceStatusModel *model = [[CTServiceStatusModel alloc]init];
    model.token = self.token;
    model.isCanceled = YES;;
    [result put:model];
    [self operationDidFinish];
}
- (void)operationDidFinish
{
    [CTSenderManager removeTaskWith:self.token];
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
        
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}
#pragma mark - --------------------手势事件--------------------

-(void)parseJSONData
{
    if (self.isCancelled ){
        [self cancelOperation];
        return ;
    }
    NSDictionary *resultDic = nil;
    NSString *responseString = @"";
    responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    responseString = [DESUtility decryptUseDES:responseString];
//    NSLog(@"----%@",responseString);
    resultDic = [[[SBJsonParser alloc]init] objectWithString:responseString];
    if (!resultDic) {
    
        CTServiceResultQueue *result = [CTSenderManager getServiceReslutQueue:self.token];
        CTServiceStatusModel *model = [[CTServiceStatusModel alloc]init];
        model.token = self.token;
        model.isSuccess = NO;
        model.errorInfo = @"抱歉，服务器出现异常，请稍后再试！";
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic setObject:model forKey:ERRINFO_MODEL];
        self.callBack.senderFail(self,nil);
        [result put:model];
    } else {//数据解析成功调用
        CTServiceResultQueue *result = [CTSenderManager getServiceReslutQueue:self.token];
        CTServiceStatusModel *model = [[CTServiceStatusModel alloc]init];
        model.token = self.token;
        model.isSuccess = YES;
        [result put:model];
        self.callBack.senderSuccess(self,resultDic);
        
    }

}
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------
#pragma mark - NSURLConnection代理
// 收到响应时, 会触发
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse{
    if (self.isCancelled){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        return ;
    }
//    NSLog(@"File Size %lld byte",aResponse.expectedContentLength);
}

- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data{
    if (self.isCancelled || self.cancelTask){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        return ;
    }
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (self.isCancelled){
        return ;
    }
    CTURLConnection *connect = (CTURLConnection *)aConn;
    if (connect.isCancel) {
        [self cancelOperation];
        return;
    } else {
        NSInteger errorCode = error.code;
        CTServiceResultQueue *result = [CTSenderManager getServiceReslutQueue:connect.token];
        CTServiceStatusModel *model = [[CTServiceStatusModel alloc]init];
        model.token = connect.token;
        model.isSuccess = NO;
        model.errorCode = [NSString stringWithFormat:@"%ld",(long)errorCode];
        model.errorInfo = [self getErrorInfoWithCode:errorCode];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic setObject:model forKey:ERRINFO_MODEL];
        self.callBack.senderFail(self,dic);
        [result put:model];
    }
    [self operationDidFinish];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConn{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    CTURLConnection *connect = (CTURLConnection *)aConn;
    if (connect.isCancel) {
        [self cancelOperation];
        return ;
    } else {
        [self parseJSONData];
    }
    [self operationDidFinish];
}


#pragma mark - --------------------属性相关--------------------
#pragma mark - --------------------接口API--------------------
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

-(void)cancelCurrenTask{
    [self.connection cancelConnection];
    [self cancelOperation];
}
-(NSString *)getErrorInfoWithCode:(NSInteger)code
{
    NSString *resultStr = @"网络不给力，稍后再试试吧";
    switch (code) {
        case -1001:
             resultStr = @"请求超时请稍后重试";
            break;
        case -1003:
            resultStr = @"服务器乘坐诺亚方舟去了,马上回来";
            break;
        case -1009:
            resultStr = @"网络不给力，稍后再试试吧";
            break;
        case -1100:
            resultStr = @"服务器异常，稍后再试试吧";
            break;
        case -1:
            resultStr = @"当前网络出现未知错误，稍后再试试吧";
            break;
        default:
            break;
    }
    return resultStr;
}
@end
