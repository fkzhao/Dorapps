//
//  NWTokenUtil.m
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWTokenUtil.h"

@implementation NWTokenUtil
+(NSString *)createToken
{
    int numberLen = 16;
    char data[numberLen];
    for (int x=0;x<numberLen;data[x++] = (char)('a' + (arc4random_uniform(26))));
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:numberLen encoding:NSUTF8StringEncoding];
    randomStr = [NSString stringWithFormat:@"%@-%@",randomStr,[self getCurrentTimeMillisecond]];
    return randomStr;
}
+ (NSDate *)getCurrentDate
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

+(NSString *) getCalendarStrBySimpleDateFormat:(NSDate *)date
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

+(NSString *) getCurrentTimeMillisecond
{
    NSDate *date = [self getCurrentDate];
    return [self getCalendarStrBySimpleDateFormat:date];
}

@end
