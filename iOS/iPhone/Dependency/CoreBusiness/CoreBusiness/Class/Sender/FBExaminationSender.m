//
//  FBExaminationSender.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-6-27.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "FBExaminationSender.h"
#import "FBExaminationRequest.h"
#import "FBExaminationResponse.h"
#import "FBViewCacheBean.h"

@implementation FBExaminationSender

-(FBServiceResultModel *)sendGetProductList
{
    FBServiceResultModel *resultModel = [self createSenderResult:NSStringFromClass([self class]) methodName:NSStringFromSelector(_cmd)];
    FBExaminationRequest *request = [[FBExaminationRequest alloc]init];
    request.urlString = @"http://61.155.215.53/api/iphone/home_page";
    request.httpMethod = NWNetworkHttpMethod_GET;
    request.region = @"CN";
    request.token = resultModel.resultToke;
    FBServiceCallBack *callBack = [[FBServiceCallBack alloc]init];
    ServiceSuccessMethod successMethod = ^(FBExaminationRequest *request,FBExaminationResponse *response)
    {
        NSLog(@"%@",response.token);
        return YES;
    };
    ServiceFailMethod failMethod = ^(FBExaminationRequest *request,FBExaminationResponse *response)
    {
        return NO;
    };
    callBack.serviceSuccess = successMethod;
    callBack.serviceFail = failMethod;
    FBExaminationResponse *response = [[FBExaminationResponse alloc]init];
    response.token = resultModel.resultToke;
    [[NWRequestQueue ShareQueue] submitNetWorkTask:resultModel.resultToke withRequest:request withResponse:response withCallBack:callBack];
    return resultModel;
}

@end
