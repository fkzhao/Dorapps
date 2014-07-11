//
//  NWAppDetailRequest.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWAppDetailRequest.h"
#import "NWURLDefine.h"

@implementation NWAppDetailRequest

-(id) init
{
    self = [super init];
    if (self) {
        self.urlString = NWGlobalAppDetailURL;
        self.appID = @"";
    }
    return self;
}

-(void)setAppID:(NSString *)appID
{
    if (_appID) {
        _appID = nil;
    }
    _appID = appID;
}

-(void)assemblyRequestParametersDictionary
{
    [self.parametersDic removeAllObjects];
    [self.parametersDic setObject:_appID forKey:@"id"];
}
@end
