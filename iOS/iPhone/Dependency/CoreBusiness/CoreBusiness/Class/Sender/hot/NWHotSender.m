//
//  NWHotSender.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotSender.h"
#import "NWHotAppRequest.h"
#import "NWHotAppResponse.h"
#import "NWAppDetailRequest.h"

@implementation NWHotSender

-(NWSenderResultModel *)sendGetHotAppList {
    NWSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetHotAppList))];
    NWHotAppRequest *request = [[NWHotAppRequest alloc]init];
    request.token = resultModel.resultToke;
    NWServiceCallBack *callBack = [[NWServiceCallBack alloc]init];
    ServiceSuccessMethod successMethod = ^(NWRequest *request,NWResponse *response)
    {
        NWViewCacheBean *cacheBean = [NWViewCacheBeanManager getViewCacheBean:resultModel.resultToke];
        [cacheBean assemblyViewCacheBean:response.responseDictory];
        return YES;
    };
    ServiceFailMethod failMethod = ^(NWRequest *request,NWResponse *response)
    {
        return NO;
    };
    callBack.serviceSuccess = successMethod;
    callBack.serviceFail = failMethod;
    NWHotAppResponse *response = [[NWHotAppResponse alloc]init];
    response.token = resultModel.resultToke;
    [[NWRequestQueue ShareQueue] submitNetWorkTask:resultModel.resultToke withRequest:request withResponse:response withCallBack:callBack];
    return resultModel;
}

-(NWSenderResultModel *)sendGetMoreHotApps:(NSInteger)page {
    return nil;
}

-(NWSenderResultModel *)sendRefreshHotAppList {
    return nil;
}

-(NWSenderResultModel *)sendGetAppDetail:(NSString *)appID {
    NWSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetHotAppList))];
    NWAppDetailRequest *request = [[NWAppDetailRequest alloc]init];
    request.appID = appID;
    request.token = resultModel.resultToke;
    NWServiceCallBack *callBack = [[NWServiceCallBack alloc]init];
    ServiceSuccessMethod successMethod = ^(NWRequest *request,NWResponse *response)
    {
        NWViewCacheBean *cacheBean = [NWViewCacheBeanManager getViewCacheBean:resultModel.resultToke];
        [cacheBean assemblyViewCacheBean:response.responseDictory];
        return YES;
    };
    ServiceFailMethod failMethod = ^(NWRequest *request,NWResponse *response)
    {
        return NO;
    };
    callBack.serviceSuccess = successMethod;
    callBack.serviceFail = failMethod;
    NWResponse *response = [[NWResponse alloc]init];
    response.token = resultModel.resultToke;
    [[NWRequestQueue ShareQueue] submitNetWorkTask:resultModel.resultToke withRequest:request withResponse:response withCallBack:callBack];
    return resultModel;
}

@end
