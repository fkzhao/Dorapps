//
//  CTProductListSender.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTProductListSender.h"
#import "CTViewCacheManage.h"
#import "CTDataSource.h"

static CTProductListSender *sender = nil;
@implementation CTProductListSender

/* 暂时不做单例**/
+(CTProductListSender *)getInstance
{
    if (sender == nil) {
        sender = [[CTProductListSender alloc]init];
    }
    return sender;
}
/**
 获取产品详情
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductDetail:(NSString *)productID
{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,LIST_API];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    [model.parameterDic setObject:productID forKey:@"product_code"];
    
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
    [CTSenderManager sendTaskWithToken:resultModel.resultToke withCallBack:callback withRequestModel:model];
    return resultModel;
}
/**
 获取更多产品
 
 @param	无
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetMoreProduct
{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,LIST_API];
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
    [CTSenderManager sendTaskWithToken:resultModel.resultToke withCallBack:callback withRequestModel:model];
    return resultModel;

}
/**
 获取对应产品的产品类表
 
 @param cacheBean 页面的CacheBean
 @param	productID   产品类型
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(CTProductListCacheBean *)cacheBean withProductID:(NSString *)productID
{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,LIST_API];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    model.HTTPBody = [NSString stringWithFormat:@"keyword=%@",productID];
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
/**
 获取产品列表
 
 @param cacheBean 页面的CacheBean
@param	keywords	产品分类关键字
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(CTProductListCacheBean *)cacheBean withKeywords:(NSArray *)keywords{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@stayreal_category.php",httpURL];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [postDic setObject:keywords forKey:@"data"];
    SBJsonWriter *write = [[SBJsonWriter alloc]init];
    NSString *postStr = [write stringWithObject:postDic];
    [model.parameterDic setObject:postStr forKey:@"category"];

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
/**
 获取对应产品的产品类表
 
 @param cacheBean 页面的CacheBean
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetNewProductList:(CTProductListCacheBean *)cacheBean
{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,LOAD_LIST_API];
    
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
