//
//  CTOperationQueue.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-6.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTOperationQueue.h"

#define MAX_OPERATION_QUEUE 20      //允许并发的最大数目

@implementation CTOperationQueue

#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------

-(id)init
{
    self = [super init];
    if (self) {
        [self setMaxConcurrentOperationCount:MAX_OPERATION_QUEUE];
    }
    return self;
}

#pragma mark - --------------------System--------------------
#pragma mark - --------------------功能函数--------------------
#pragma mark - --------------------手势事件--------------------
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------
#pragma mark - --------------------属性相关--------------------
#pragma mark - --------------------接口API--------------------
@end
