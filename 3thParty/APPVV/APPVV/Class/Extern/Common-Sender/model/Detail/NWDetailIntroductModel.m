//
//  NWDetailIntroductModel.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDetailIntroductModel.h"

@implementation NWDetailIntroductModel


-(id)init
{
    self = [super init];
    if (self) {
        self.descriptionInfo = @"";
        self.screenShots = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

@end
