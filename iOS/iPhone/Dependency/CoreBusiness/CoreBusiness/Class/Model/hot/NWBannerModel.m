//
//  NWBannerModel.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWBannerModel.h"

@implementation NWBannerModel

-(id)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.url = @"";
        self.appID = @"";
    }
    return self;
}

-(void)setAppID:(NSString *)appID
{
    if (_appID) {
        _appID = @"";
    }
    _appID = [appID stringByReplacingOccurrencesOfString:@"ID=" withString:@""];
}
@end
