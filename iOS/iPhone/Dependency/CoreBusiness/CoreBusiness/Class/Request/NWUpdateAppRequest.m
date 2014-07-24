//
//  NWUpdateAppRequest.m
//  CoreBusiness
//
//  Created by Anselz on 14-7-24.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWUpdateAppRequest.h"
#import "NWURLDefine.h"


@implementation NWUpdateAppRequest

-(id) init
{
    self = [super init];
    if (self) {
        self.urlString = NWGlobalAppUpdateURL;
    }
    return self;
}

-(void)assemblyRequestParametersDictionary
{
    [self.parametersDic removeAllObjects];
    [self.parametersDic setObject:@"com%2Etencent%2Exin%7C5%2E0" forKey:@"bid"];
}

@end
