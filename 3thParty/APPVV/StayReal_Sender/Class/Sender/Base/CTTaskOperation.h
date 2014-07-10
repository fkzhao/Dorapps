//
//  CTTaskOperation.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-6.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CTURLConnection.h"
#import "CTURLRequest.h"
#import "SBJsonParser.h"
#import "CTMutableURLRequest.h"
#import "CTSenderCallBack.h"
#import "CTRequestModel.h"
#import "DESUtility.h"
/** 执行网络请求的操作*/
@interface CTTaskOperation : NSOperation<NSURLConnectionDelegate>
{
    NSMutableData *responseData;
}

/* 当前任务的的token**/
@property (strong,nonatomic) NSString *token;
/* 当前任务的的token**/
@property (strong,nonatomic) CTRequestModel *requestModel;
/* 当前任务的的回调**/
@property (strong,nonatomic) CTSenderCallBack *callBack;
/* 网络连接**/
@property (strong,nonatomic) CTURLConnection *connection;
/* 网络连接**/
@property (unsafe_unretained,nonatomic) BOOL cancelTask;
/**
 	根据token初始化对象
 
 	@param	token	当前对象的token
    @param  callBack 回调
    @return 返回当前对象的实例
 */
-(id)initWithToken:(NSString *)token callBack:(CTSenderCallBack *)callBack;

-(void)cancelCurrenTask;
+ (NSThread *)networkThread;

@end
