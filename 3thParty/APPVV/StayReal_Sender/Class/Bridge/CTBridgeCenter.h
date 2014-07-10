//
//  CTBridgeCenter.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-3.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTBridgeCenter.h"
#import "CTServiceStatusModel.h"

/** 自定义通知中心Model 方便使用*/
@interface CTBridgeCenterModel : NSObject

/* 名称**/
@property (strong, nonatomic) NSString *name;
/* 目标实例**/
@property (unsafe_unretained,nonatomic) id target;
/** 目标选择器*/
@property (unsafe_unretained,nonatomic) SEL selector;
/** 传参字典*/
@property (unsafe_unretained,nonatomic) NSMutableDictionary *dic;

@end

/** 自定义通知中心（类似于通知中心）*/
@interface CTBridgeCenter : NSObject

/**
 获取自定义推送中心的单例
 
 @prama 无参数
 
 @return	CTBridgeCenter类型的实例
 */
+(CTBridgeCenter *)defaultBridgeCenter;

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
             withObject:(id)dic;

/**
 从线程池中推出服务成功消息
 
 @prama name     名字
 
 @return nil 不需要返回值
 */
-(void)pushSccessMessageWithName:(NSString *)name;

/**
 从线程池中推出服务失败消息
 
 @prama name     名字
 
 @return nil 不需要返回值
 */
-(void)pushFailedMessageWithName:(NSString *)name errorInfo:(NSString *)info;
@end
