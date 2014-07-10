//
//  NWHotSender.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotSender.h"
#import "CTViewCacheManage.h"

@implementation NWHotSender

-(CTSenderResultModel *)sendGetHotAppList {
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetHotAppList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@",@"http://app.dorapps.com/api/iphone/home_page"];
    model.HTTPMethod = eHTTPREQUEST_METHOD_GET;
    
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

-(CTSenderResultModel *)sendGetMoreHotApps:(NSInteger)page {
    return nil;
}

-(CTSenderResultModel *)sendRefreshHotAppList {
    return nil;
}

-(CTSenderResultModel *)sendGetAppDetail:(NSString *)appID {
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetHotAppList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",@"http://app.dorapps.com/api/app/detail?id=",appID];
    model.HTTPMethod = eHTTPREQUEST_METHOD_GET;
    
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
