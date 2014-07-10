//
//  CTMenuSender.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTMenuSender.h"

@implementation CTMenuSender
/**
 获取产品列表
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(NSString *)categoryID{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,LIST_API];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    model.HTTPBody = [NSString stringWithFormat:@"keyword=%@",categoryID];    CTSenderCallBack *callback = [[CTSenderCallBack alloc] init];
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
 获取产品分类里列表
 
 @param	cacheBean 需要填充的cacheBean
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetCategoryList:(CTMenuCacheBean *)cacheBean
{
    return nil;
}
@end
