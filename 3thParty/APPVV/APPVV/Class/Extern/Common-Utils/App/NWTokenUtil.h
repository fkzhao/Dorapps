//
//  NWTokenUtil.h
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWTokenUtil : NSObject

+ (NSString *)createToken;
+ (NSDate *)getCurrentDate;
+ (NSString *) getCalendarStrBySimpleDateFormat:(NSDate *)date;
+ (NSString *) getCurrentTimeMillisecond;

@end
