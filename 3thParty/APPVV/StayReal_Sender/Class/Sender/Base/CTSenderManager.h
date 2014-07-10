//
//  CTSenderManager.h
//  StayReal_Sender
//
//  Created by Ansel on 13-7-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSenderResultModel.h"
#import "CTURLConnection.h"
#import "CTServiceResultQueue.h"
#import "CTServiceStatusModel.h"
#import "CTConfig.h"
#import "CTOperationQueue.h"
#import "CTSenderCallBack.h"
#import "CTViewCacheBean.h"
#import "CTRequestModel.h"

/* 定义任务状态类型**/
typedef enum {
    eTaskStatusDefault,  //没有任务
    eTaskStatusCanceled, //任务取消
    eTaskStatusExecuting,//任务正在执行
    eTaskStatusFinished, //任务结束
}eTaskStatus;
/* 发送服务的父类**/
@interface CTSenderManager : NSObject

/* 执行任务的操作队列**/
@property (strong , nonatomic) CTOperationQueue *taskOperationQueue;


/* 请求服务**/

/**
 	获取单例的方法
 
    @prama  nil 不需要参数
 
 	@return	返回一个sender实力
 */
+(CTSenderManager *)shareInstance;

/**
 设置服务结果队列
 
 @param	token	服务的token
 @param queue   服务队列
 
 @return	BOOL 设置成功为YES，否则为NO
 */
+(BOOL)setServiceReslutQueue:(NSString *)token withQueu:(CTServiceResultQueue *)queue;
/**
 	获取服务结果队列
 
 	@param	token	服务的token
 
 	@return	CTServiceResultQueue 对象
 */
+(CTServiceResultQueue *)getServiceReslutQueue:(NSString *)token;
/**
 	移除服务队列
 
 	@param	token	服务的token
 
    @return 不需要返回值
 */
+(void)removeServiceResultQueue:(NSString *)token;

/**
 	清除所有记录
 
 	@param	token	toke
    
    @return 不需要返回值
 */
+(void)clearAllWithToken:(NSString *)token;


/**
 发送任务
 
 @param	token	token
 
 @return 不需要返回值
 */

+(void)sendTaskWithToken:(NSString *)token withCallBack:(CTSenderCallBack *)callBack withRequestModel:(CTRequestModel *)requestModel;

/** 
 取消服务
 
 @param token token
 
 @return 不需要返回值
 */
+(void)cancelTask:(NSString *)token;

/**
 获取任务的执行状态
 
 @param token token
 
 @return 任务的执行状态
 */
+(eTaskStatus)getTaskStatus:(NSString *)token;
/**
 移除任务
 
 @param token token
 
 @return 不需要返回值
 */
+(void)removeTaskWith:(NSString *)token;
@end
