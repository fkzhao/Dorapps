//
//  UIDevice+JailBreak.m
//  Dorapps
//
//  Created by Anselz on 14-8-9.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "UIDevice+JailBreak.h"

@implementation UIDevice (JailBreak)
#define USER_APP_PATH                 @"/User/Applications/"
+ (BOOL)isJailBreak
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
//        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
        return YES;
    }
    return NO;
}
@end
