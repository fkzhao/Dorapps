//
//  CTServiceStatusModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-4.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTServiceStatusModel.h"

@implementation CTServiceStatusModel
#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------
-(id)init{
    self = [super init];
    if (self) {
        self.isSuccess = NO;
        self.isCanceled = NO;
        self.errorInfo = @"";
        self.errorCode = @"";
        self.token = @"";
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
