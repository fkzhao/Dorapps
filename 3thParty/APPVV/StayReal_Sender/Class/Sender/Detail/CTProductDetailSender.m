//
//  CTProductDetailSender.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTProductDetailSender.h"
#import "CTViewCacheManage.h"

@implementation CTProductDetailSender
/**
 获取相关产品详情
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetAboutProductDetail:(NSString *)productID{
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,DETAIL_API];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    [model.parameterDic setObject:productID forKey:@"product_code"];
    [model.parameterDic setObject:__dataSource.region forKey:@"region"];
    
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
@end
