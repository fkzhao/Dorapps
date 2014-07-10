//
//  CTSender.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTSenderResultModel.h"
#import "CTSenderManager.h"
#import "CTSenderCallBack.h"
#import "CTServiceStatusModel.h"
#import "CTViewCacheManage.h"
#import "SBJsonWriter.h"


/* 发送服务的父类**/
@interface CTSender : NSObject

/**
 	根据类名和方法名生成Token
 
 	@param	className	类名
 	@param	methodName	方法名
 
 	@return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *) createSenderResult:(NSString *)className methodName:(NSString *)methodName;

+(void)setServiceAndCacheBeanQueue:(NSString *)token;
@end
