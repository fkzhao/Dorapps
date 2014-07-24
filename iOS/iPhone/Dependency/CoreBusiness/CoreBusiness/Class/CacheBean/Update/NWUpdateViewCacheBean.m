//
//  NWUpdateViewCacheBean.m
//  CoreBusiness
//
//  Created by Anselz on 14-7-24.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWUpdateViewCacheBean.h"
@implementation NWUpdateAppModel

-(id)init
{
    self = [super init];
    if (self) {
        self.appIcon = @"";
        self.appName = @"";
        self.appDownloadURL = @"";
        self.appSize = @"";
        self.appVersion = @"";
    }
    return self;
}
@end


@implementation NWUpdateViewCacheBean

-(id)init {
    self = [super init];
    if (self) {
        self.appListArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

-(void)assemblyViewCacheBean:(NSDictionary *)dic {
    [self.appListArray removeAllObjects];
    NSString *code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    if ([code isEqualToString:@"1000"]) {
        NSDictionary *apps = [dic objectForKey:@"data"];
        for (NSDictionary *app in apps) {
            NWUpdateAppModel *model = [[NWUpdateAppModel alloc]init];
            model.appName = [NSString stringWithFormat:@"%@",[app objectForKey:@"trackName"]];
            model.appIcon = [NSString stringWithFormat:@"%@",[app objectForKey:@"icon"]];
            model.appDownloadURL = [NSString stringWithFormat:@"%@",[app objectForKey:@"ipaURL"]];
            model.appVersion = [NSString stringWithFormat:@"%@",[app objectForKey:@"version"]];
            model.appSize = [NSString stringWithFormat:@"%@",[app objectForKey:@"size"]];
            [self.appListArray addObject:model];
        }
        
    }
}

@end
