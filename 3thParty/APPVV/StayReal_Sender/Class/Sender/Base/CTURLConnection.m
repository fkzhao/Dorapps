//
//  CTURLConnection.m
//  StayReal_Sender
//
//  Created by Ansel on 13-7-23.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTURLConnection.h"

@implementation CTURLConnection
@synthesize token;

#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------

-(id)init{
    self = [super init];
    if (self) {
        self.token = @"";
        self.isCancel = NO;
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
-(void)cancelConnection{
    self.isCancel = YES;
//    [self cancel];
}
@end
