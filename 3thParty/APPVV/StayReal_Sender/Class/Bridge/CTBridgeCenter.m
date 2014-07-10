//
//  CTBridgeCenter.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-3.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTBridgeCenter.h"

@implementation CTBridgeCenterModel

-(id)init{
    self = [super init];
    if (self) {
        self.name = @"";
        self.target = nil;
        self.selector = nil;
        self.dic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

@end

@interface CTBridgeCenter ()
/** token的字典*/
@property (strong, nonatomic)NSMutableDictionary *tokenDic;

@end
static CTBridgeCenter *shareBridage = nil;
@implementation CTBridgeCenter

#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------

-(id)init{
    self = [super init];
    if (self) {
        self.tokenDic = [[NSMutableDictionary alloc]initWithCapacity:0];
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
/**
    获取自定义推送中心的单例
 
 	@prama 无参数
 
 	@return	CTBridgeCenter类型的实例
 */
+(CTBridgeCenter *)defaultBridgeCenter{
    if (!shareBridage) {
        shareBridage = [[CTBridgeCenter alloc]init];
    }
    return shareBridage;
}

/**
 在线程池中注册相应操作,等待服务完成调用
 
 @prama name     名字
 @prama target   目标实例
 @prama selector 方法
 @prama dic      参数字典
 
 @return nil 不需要返回值
 */
-(void)registerWithName:(NSString *)name
                 target:(id)target
               selector:(SEL)selector
             withObject:(id)dic{
    BOOL flag = YES;
    //遍历当前tokenDic
    NSArray *keys;
    int i, count;
    keys = [self.tokenDic allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithFormat:@"%@",[keys objectAtIndex: i]];
        if ([key isEqualToString:name]) {
            flag = NO;
        }
    }
    if (flag) {
        CTBridgeCenterModel *model = [[CTBridgeCenterModel alloc]init];
        model.name = name;
        model.target = target;
        model.selector = selector;
        model.dic = dic;
        [self.tokenDic setObject:model forKey:name];
    }
}

/**
 从线程池中推出消息
 
 @prama name     名字
 
 @return nil 不需要返回值
 */
-(void)pushSccessMessageWithName:(NSString *)name{
    //遍历当前tokenDic
    NSArray *keys;
    int i, count;
    keys = [self.tokenDic allKeys];
    count = [keys count];
    id key = nil;
    for (i = 0; i < count; i++)
    {
        CTBridgeCenterModel *model = (CTBridgeCenterModel *)[self.tokenDic objectForKey:[keys objectAtIndex:i]];
        if ([model.name isEqualToString:name]) {
            if ([model.target respondsToSelector:model.selector]) {
                CTServiceStatusModel *serviceModel = [[CTServiceStatusModel alloc] init];
                serviceModel.isSuccess = YES;
                serviceModel.token = model.name;
                [model.target performSelector:model.selector onThread:[NSThread mainThread] withObject:serviceModel waitUntilDone:NO];
                key = [keys objectAtIndex:i];
                break;
            }
        }
    }
    if (key) {
        [self.tokenDic removeObjectForKey:key];
    }
}

/**
 从线程池中推出服务失败消息
 
 @prama name     名字
 
 @return nil 不需要返回值
 */
-(void)pushFailedMessageWithName:(NSString *)name errorInfo:(NSString *)info
{
    //遍历当前tokenDic
    NSArray *keys;
    int i, count;
    keys = [self.tokenDic allKeys];
    count = [keys count];
    id key = nil;
    for (i = 0; i < count; i++)
    {
        CTBridgeCenterModel *model = (CTBridgeCenterModel *)[self.tokenDic objectForKey:[keys objectAtIndex:i]];
        if ([model.name isEqualToString:name]) {
            if ([model.target respondsToSelector:model.selector]) {
                CTServiceStatusModel *serviceModel = [[CTServiceStatusModel alloc] init];
                serviceModel.isSuccess = NO;
                serviceModel.errorInfo = info;
                serviceModel.token = model.name;
                [model.target performSelector:model.selector onThread:[NSThread mainThread] withObject:serviceModel waitUntilDone:NO];
                key = [keys objectAtIndex:i];
                break;
            }
        }
    }
    if (key) {
        [self.tokenDic removeObjectForKey:key];
    }
}
@end
