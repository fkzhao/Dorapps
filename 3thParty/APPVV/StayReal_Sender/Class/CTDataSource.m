//
//  CTDataSource.m
//  StayReal_Sender
//
//  Created by Anselz on 13-11-4.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTDataSource.h"
CTDataSource *__dataSource;
void initDataSource()
{
    if (__dataSource == nil) {
        __dataSource = [[CTDataSource alloc] init];
    }
}

void freeDataSource()
{
    __dataSource = nil;
}

@implementation CTDataSource
-(id)init{
    self = [super init];
    if (self) {
        self.isShowImage = YES;
        self.httpURL = httpURL;
        self.region = @"";
    }
    return self;
}
@end
