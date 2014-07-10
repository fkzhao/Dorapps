//
//  CTServiceStatusModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-4.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 服务状态model**/
@interface CTServiceStatusModel : NSObject

/* 服务是否成功**/
@property (unsafe_unretained,nonatomic) BOOL isSuccess;
/** 服务错误信息*/
@property (strong,nonatomic) NSString *errorInfo;
/** TOKEN*/
@property (strong,nonatomic) NSString *token;
@end
