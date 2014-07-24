//
//  NWHotAppRequest.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotAppRequest.h"
#import "NWURLDefine.h"

@implementation NWHotAppRequest

-(id) init
{
    self = [super init];
    if (self) {
        self.urlString = NWGlobalHotAppListURL;
    }
    return self;
}

@end
