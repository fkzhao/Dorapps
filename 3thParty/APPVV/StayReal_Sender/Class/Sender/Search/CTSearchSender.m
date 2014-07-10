//
//  CTSearchSender.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSearchSender.h"
#import "CTViewCacheManage.h"
@implementation CTSearchSender
/**
 获取产品列表
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(int)productID{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    CTCacheBeanResultQueue *cacheQueue = [[CTCacheBeanResultQueue alloc]init];
    [[CTViewCacheManage shareInstance] setCacheQueueWithToken:resultModel.resultToke cacheBeanQueue:cacheQueue];
    CTSenderCallBack *callback = [[CTSenderCallBack alloc] init];
    SenderSuccessMethod successMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
        CTViewCacheBean *cache = nil;
        CTCacheBeanResultQueue * queue = [[CTViewCacheManage shareInstance] getCacheQueueWithToken:resultModel.resultToke];
        cache = (CTViewCacheBean *)[queue getCacheBean];//这个地方会阻塞，知道cacheBean创建完成
        [[CTViewCacheManage shareInstance] removeCacheQueueWithToken:resultModel.resultToke];
        [cache assemblyViewCacheBean:dic];
        return YES;
    };
    
    SenderFailMethod failMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
        return NO;
    };
    callback.senderFail = failMethod;
    callback.senderSuccess = successMethod;
    [CTSenderManager sendTaskWithToken:resultModel.resultToke withCallBack:callback withRequestModel:nil];
    return resultModel;
}
/**
 获取产品列表
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductDetail:(NSString *)productID{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,DETAIL_API];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    model.HTTPBody = [NSString stringWithFormat:@"product_code=%@",productID];
    CTSenderCallBack *callback = [[CTSenderCallBack alloc] init];
    SenderSuccessMethod successMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
        
        CTViewCacheBean *cache = nil;
        CTCacheBeanResultQueue * queue = [[CTViewCacheManage shareInstance] getCacheQueueWithToken:resultModel.resultToke];
        cache = (CTViewCacheBean *)[queue getCacheBean];//这个地方会阻塞，知道cacheBean创建完成
        [[CTViewCacheManage shareInstance] removeCacheQueueWithToken:resultModel.resultToke];        [cache assemblyViewCacheBean:dic];
        return YES;
    };
    
    SenderFailMethod failMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
        return NO;
    };
    callback.senderFail = failMethod;
    callback.senderSuccess = successMethod;
    [CTSenderManager sendTaskWithToken:resultModel.resultToke withCallBack:callback withRequestModel:model];
    return resultModel;

}

/**
 获取产品列表
 
 @param	keyWord 关键字
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetSearchResults:(CTSearchCacheBean *)cacheBean withKeyWord:(NSString *)keyWord{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,SEARCH_API];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    [model.parameterDic setObject:keyWord forKey:@"keyword"];
    CTSenderCallBack *callback = [[CTSenderCallBack alloc] init];
    SenderSuccessMethod successMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
        CTViewCacheBean *cache = cacheBean;
        [cache assemblyViewCacheBean:dic];
        return YES;
    };
    
    SenderFailMethod failMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
        return NO;
    };
    callback.senderFail = failMethod;
    callback.senderSuccess = successMethod;
    [CTSenderManager sendTaskWithToken:resultModel.resultToke withCallBack:callback withRequestModel:model];
    return resultModel;

}
@end
