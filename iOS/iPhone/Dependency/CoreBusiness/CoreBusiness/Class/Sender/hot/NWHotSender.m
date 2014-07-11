//
//  NWHotSender.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotSender.h"

@implementation NWHotSender

-(NWSenderResultModel *)sendGetHotAppList {
    NWSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetHotAppList))];
    NWRequest *request = [[NWRequest alloc]init];
    request.urlString = @"http://61.155.215.53/api/iphone/home_page";
    request.httpMethod = NWNetworkHttpMethod_GET;
    request.token = resultModel.resultToke;
    NWServiceCallBack *callBack = [[NWServiceCallBack alloc]init];
    ServiceSuccessMethod successMethod = ^(NWRequest *request,NWResponse *response)
    {
        NSLog(@"%@",response.token);
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
    return resultModel;}

-(NWSenderResultModel *)sendGetMoreHotApps:(NSInteger)page {
    return nil;
}

-(NWSenderResultModel *)sendRefreshHotAppList {
    return nil;
}

-(NWSenderResultModel *)sendGetAppDetail:(NSString *)appID {
    NWSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetHotAppList))];
    NWRequest *request = [[NWRequest alloc]init];
    request.urlString =[NSString stringWithFormat:@"%@%@",@"http://app.dorapps.com/api/app/detail?id=",appID];
    request.httpMethod = NWNetworkHttpMethod_GET;
    request.token = resultModel.resultToke;
    NWServiceCallBack *callBack = [[NWServiceCallBack alloc]init];
    ServiceSuccessMethod successMethod = ^(NWRequest *request,NWResponse *response)
    {
        NSLog(@"%@",response.token);
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
