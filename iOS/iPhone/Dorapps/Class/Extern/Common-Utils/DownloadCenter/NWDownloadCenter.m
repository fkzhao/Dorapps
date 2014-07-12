//
//  NWDownloadCenter.m
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadCenter.h"

@implementation NWDownloadCenter

+(instancetype)defaultCenter
{
    static NWDownloadCenter *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self alloc]init];
    });
    return obj;
}

@end
