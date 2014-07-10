//
//  CTSenderManager.m
//  StayReal_Sender
//
//  Created by Ansel on 13-7-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSenderManager.h"
#import <UIKit/UIKit.h>
#import "CTTaskOperation.h"
@interface CTSenderManager()
{
    
}
/* 任务执行结果池**/
@property (strong , nonatomic) NSMutableDictionary *resultPool;
/* 存放任务dic**/
@property (strong , nonatomic) NSMutableDictionary *taskDictionary;

/* 执行操作的锁**/
@property(nonatomic, readwrite, strong) NSRecursiveLock *lock;
@end

static CTSenderManager *share = nil;
@implementation CTSenderManager
@synthesize resultPool;


#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------

-(id)init{
    self = [super init];
    if (self) {
        self.resultPool = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.taskDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.taskOperationQueue = [[CTOperationQueue alloc]init];
        self.lock = [[NSRecursiveLock alloc]init];
        self.lock.name = @"com.stayreal.sender.lock";
    }
    return self;
}

#pragma mark - --------------------System--------------------
#pragma mark - --------------------功能函数--------------------
/**
 	检查
 
 	@param	dic	需要检查的字典
 	@param	key	需要检查的key
 
 	@return	BOOL 如果存在返回YES,否则返回NO
 */
-(BOOL)checkDiction:(NSDictionary *)dic withKey:(id)key{
    if ([[dic allKeys] containsObject:key]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - --------------------手势事件--------------------
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------
#pragma mark - --------------------属性相关--------------------
#pragma mark - --------------------接口API--------------------

+(CTSenderManager *)shareInstance
{
    if (!share) {
        share = [[CTSenderManager alloc]init];
    }
    return share;
}
/**
 设置服务结果队列
 
 @param	token	服务的token
 
 @return	CTServiceResultQueue 对象
 */
+(BOOL)setServiceReslutQueue:(NSString *)token  withQueu:(CTServiceResultQueue *)queue{
    CTSenderManager *sender = [CTSenderManager shareInstance];
    [sender.lock lock];
    if (![[sender.resultPool allKeys] containsObject:token]){
         [sender.resultPool setObject:queue forKey:token];
        [sender.lock unlock];
         return YES;
    } else {
        [sender.lock unlock];
        return NO;
    }
}
/**
 获取服务结果队列
 
 @param	token	服务的token
 
 @return	CTServiceResultQueue 对象
 */
+(CTServiceResultQueue *)getServiceReslutQueue:(NSString *)token{
    CTSenderManager *sender = [CTSenderManager shareInstance];
    [sender.lock lock];
    if ([[sender.resultPool allKeys] containsObject:token]) {
        [sender.lock unlock];
        return (CTServiceResultQueue *)[sender.resultPool objectForKey:token];
    } else {
        [sender.lock unlock];
        return nil;
    }
}
/**
 移除服务队列
 
 @param	token	服务的token
 
 @return 不需要返回值
 */
+(void)removeServiceResultQueue:(NSString *)token{
    CTSenderManager *sender = [CTSenderManager shareInstance];
    [sender.lock lock];
    if ([[sender.resultPool allKeys] containsObject:token]) {
       [sender.resultPool removeObjectForKey:token];
    }
    [sender.lock unlock];
}

/**
 发送任务
 
 @param	token	token
 
 @return 不需要返回值
 */
+(void)sendTaskWithToken:(NSString *)token withCallBack:(CTSenderCallBack *)callBack withRequestModel:(CTRequestModel *)requestModel{
    CTSenderManager *sender = [CTSenderManager shareInstance];
    [sender.lock lock];
    CTTaskOperation *task = [[CTTaskOperation alloc]initWithToken:token callBack:callBack];
    task.requestModel = requestModel;
    [sender.taskOperationQueue addOperation:task];
    [sender.taskDictionary setObject:task forKey:token];
    [sender.lock unlock];
}

/**
 清除所有记录
 
 @param	token	toke
 
 @return 不需要返回值
 */
+(void)clearAllWithToken:(NSString *)token{
    @synchronized(token){
        [CTSenderManager removeServiceResultQueue:token];
    }
}

/**
 取消服务
 
 @param token token
 
 @return 不需要返回值
 */
+(void)cancelTask:(NSString *)token{
    @synchronized(token){
        CTSenderManager *sender = [CTSenderManager shareInstance];
        if ([[sender.taskDictionary allKeys] containsObject:token]) {
            CTTaskOperation *task = (CTTaskOperation *)[sender.taskDictionary objectForKey:token];
            [task cancel];
            [task cancelCurrenTask];
            [sender.taskDictionary removeObjectForKey:token];
        }
    }
}

/**
 获取任务的执行状态
 
 @param token token
 
 @return 不需要返回值
 */
+(eTaskStatus)getTaskStatus:(NSString *)token{
    @synchronized(token){
        CTSenderManager *sender = [CTSenderManager shareInstance];
        if ([[sender.taskDictionary allKeys] containsObject:token]) {
            CTTaskOperation *task = (CTTaskOperation *)[sender.taskDictionary objectForKey:token];
            if (task == nil) {
                return eTaskStatusFinished;
            }
            if (task.isCancelled || task.cancelTask) {
                return eTaskStatusCanceled;
            }
            if (task.isExecuting) {
                return eTaskStatusExecuting;
            }
            if (task.isFinished) {
                return eTaskStatusFinished;
            }
        } else {
            return eTaskStatusDefault;
        }
        return eTaskStatusDefault;
    }
}
/**
 移除任务
 
 @param token token
 
 @return 不需要返回值
 */
+(void)removeTaskWith:(NSString *)token{
    @synchronized(token){
        CTSenderManager *sender = [CTSenderManager shareInstance];
        if ([[sender.taskDictionary allKeys] containsObject:token]) {
            [sender.taskDictionary removeObjectForKey:token];
        }
    }
}
@end
