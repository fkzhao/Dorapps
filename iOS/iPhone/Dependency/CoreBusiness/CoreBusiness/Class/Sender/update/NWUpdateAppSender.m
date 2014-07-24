//
//  NWUpdateAppSender.m
//  CoreBusiness
//
//  Created by Anselz on 14-7-24.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWUpdateAppSender.h"
#import "NWUpdateAppRequest.h"

@implementation NWUpdateAppSender


-(NWSenderResultModel *)sendUpdateChackApp
{
    NWSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendUpdateChackApp))];
    NWUpdateAppRequest *request = [[NWUpdateAppRequest alloc]init];
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
