//
//  CTBootSender.m
//  StayReal_Sender
//
//  Created by Anselz on 13-10-29.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTBootSender.h"
#import "CTMenuCacheBean.h"

@implementation CTBootSender

/**
 获取相关产品详情
 
 @param	deviceToken	设备ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendRegistDeviceToken:(NSString *)deviceToken
                                systemVersion:(NSString *)systemVersion
                                   systemName:(NSString *)systemName
                                         UUID:(NSString *)uuid
{
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@%@",httpURL,REGISTER_DEVICE_API];
    model.HTTPMethod = eHTTPREQEUSET_METHOD_POST;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableDictionary *prameDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [prameDic setObject:deviceToken forKey:@"deviceToken"];
    [prameDic setObject:systemVersion forKey:@"systemVersion"];
    [prameDic setObject:systemName forKey:@"systemName"];
    [prameDic setObject:uuid forKey:@"UUID"];
    [postDic setObject:prameDic forKey:@"data"];
    SBJsonWriter *writer = [[SBJsonWriter alloc]init];
    NSString *postStr = [writer stringWithObject:postDic];
    model.HTTPBody = [NSString stringWithFormat:@"device=%@",postStr];
    CTSenderCallBack *callback = [[CTSenderCallBack alloc] init];
    SenderSuccessMethod successMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
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
    CTSenderResultModel *resultModel = [self createSenderResult:NSStringFromClass ([self class]) methodName:NSStringFromSelector(@selector(sendGetProductList))];
    [[self class] setServiceAndCacheBeanQueue:resultModel.resultToke];
    CTRequestModel *model = [[CTRequestModel alloc]init];
    model.url = [NSString stringWithFormat:@"%@stayreal_get_category.php",httpURL];
    model.HTTPMethod = eHTTPREQUEST_METHOD_GET;
    CTSenderCallBack *callback = [[CTSenderCallBack alloc] init];
    SenderSuccessMethod successMethod = ^(CTTaskOperation *task, NSDictionary *dic)
    {
        [cacheBean assemblyViewCacheBean:dic];
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
