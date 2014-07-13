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
        self.isFinished = [NSNumber numberWithBool:NO];
        self.isCanceled = [NSNumber numberWithBool:NO];
        self.totalsize = [NSNumber numberWithFloat:0.0];
        self.downloadedsize = [NSNumber numberWithFloat:0.0];
        self.finishtime = nil;
        self.icon = @"";
        self.name = @"";
        self.apptime = @"";
        self.version = @"";
        self.appsize = @"";
    }
    return self;
}
@end
