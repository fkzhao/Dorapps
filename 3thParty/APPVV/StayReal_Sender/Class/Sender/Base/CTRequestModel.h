//
//  CTRequestModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    eHTTPREQUEST_METHOD_GET,        //GET方式请求
    eHTTPREQEUSET_METHOD_POST,      //POST方式请求
}eHTTPREQUEST_METHOD;
/* HTTP请求model**/
@interface CTRequestModel : NSObject

/* 请求URL**/
@property (strong,nonatomic) NSString *url;
/* 请求方式GET POST**/
@property (unsafe_unretained,nonatomic) eHTTPREQUEST_METHOD HTTPMethod;
/* 如果是POST请求 需要添加请求内容(单一参数的请求)**/
@property (strong,nonatomic) NSString *HTTPBody;

/** 请求参数列表（多参数的请求）*/
@property (strong,nonatomic) NSMutableDictionary *parameterDic;

/** 
 组装请求参数
 
 @param 无
 
 @return 无
 
 */
-(void)assemblyParameters;

@end
