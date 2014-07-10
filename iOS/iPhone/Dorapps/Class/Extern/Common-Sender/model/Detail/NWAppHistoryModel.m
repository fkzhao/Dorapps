//
//  NWAppHistoryModel.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWAppHistoryModel.h"

@implementation NWAppHistoryModel

-(id)init
{
    self = [super init];
    if (self) {
        self.version = @"";
        self.iconUrl = @"";
        self.rating = @"";
    }
    return self;
}

@end
