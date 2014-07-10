//
//  CTSender.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSender.h"

@implementation CTSender

#pragma mark - --------------------退出清空--------------------
#pragma mark - --------------------初始化--------------------

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - --------------------System--------------------
#pragma mark - --------------------功能函数--------------------

- (NSDate *)getCurrentDate
{
    NSData *localTime;
    NSDate *now = [NSDate date];
    NSTimeZone *tz1 = [NSTimeZone timeZoneWithName:@"GMT"];
    NSInteger interval1 = [tz1 secondsFromGMTForDate: now];
    localTime = [now dateByAddingTimeInterval:interval1];

    
    NSDate *date = [NSDate date];
    NSTimeZone *tz2 = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSInteger interval2 = [tz2 secondsFromGMTForDate: date];
    date = [date dateByAddingTimeInterval:interval2];
    
    return date;
}

-(NSString *) getCalendarStrBySimpleDateFormat:(NSDate *)date
{
    NSString *str = @"";
    NSString *type = @"yyyyMMddHHmmssSSS";
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"GMT"];
    [dateFormater setTimeZone:tz];
    [dateFormater setDateFormat:type];
    str = [dateFormater stringFromDate:date];
    
    return str;
}
-(NSString *) getCurrentTimeMillisecond
{
    NSDate *date = [self getCurrentDate];
    return [self getCalendarStrBySimpleDateFormat:date];
}
#pragma mark - --------------------手势事件--------------------
#pragma mark - --------------------按钮事件--------------------
#pragma mark - --------------------代理方法--------------------
#pragma mark - --------------------属性相关--------------------
#pragma mark - --------------------接口API--------------------
/**
 根据类名和方法名生成Token
 
 @param	className	类名
 @param	methodName	方法名
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *) createSenderResult:(NSString *)className methodName:(NSString *)methodName{
    CTSenderResultModel * model = [[CTSenderResultModel alloc] init];
    //生成token
    NSString * tokenStr = [[NSString alloc] initWithFormat:@"%@.%@.%@",className,methodName,[self getCurrentTimeMillisecond]];
    model.resultToke = tokenStr;
    return model;
}

+(void)setServiceAndCacheBeanQueue:(NSString *)token
{
    CTCacheBeanResultQueue *cacheQueue = [[CTCacheBeanResultQueue alloc]init];
    [[CTViewCacheManage shareInstance] setCacheQueueWithToken:token cacheBeanQueue:cacheQueue];
    CTServiceResultQueue *queue = [[CTServiceResultQueue alloc]init];
    [CTSenderManager setServiceReslutQueue:token withQueu:queue];
}
@end
