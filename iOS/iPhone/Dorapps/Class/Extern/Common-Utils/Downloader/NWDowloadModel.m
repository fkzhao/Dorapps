//
//  NWDowloadModel.m
//  Dorapps
//
//  Created by Anselz on 14-8-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDowloadModel.h"

@implementation NWDowloadModel

-(id)init
{
    self = [super init];
    if (self) {
        self.appName = @"";
        self.appSize = @"";
        self.appVersion = @"";
        self.appIcon = @"";
        self.downloadURL = @"";
    }
    return self;
}

@end
