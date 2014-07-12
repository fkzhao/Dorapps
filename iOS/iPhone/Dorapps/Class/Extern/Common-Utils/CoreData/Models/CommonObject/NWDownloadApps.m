//
//  NWDownloadApps.m
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadApps.h"

@implementation NWDownloadApps

-(id)init
{
    self = [super init];
    if (self) {
        self.token = @"";
        self.url = @"";
        self.data = nil;
        self.createtime = nil;
        self.endtime = nil;
        self.finished = [NSNumber numberWithBool:NO];
    }
    return self;
}
@end
