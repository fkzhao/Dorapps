//
//  CTURLConnection.h
//  StayReal_Sender
//
//  Created by Ansel on 13-7-23.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 增强NSURLConnection*/
@interface CTURLConnection : NSURLConnection


/** 当前Connection的token*/
@property (strong,nonatomic) NSString *token;
/** 是否取消了当前Connection*/
@property (unsafe_unretained,nonatomic) BOOL isCancel;

/**
 	取消服务
 
    @prama 不要参数
 
    @return 没有返回值
 */
-(void)cancelConnection;
@end
