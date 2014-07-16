//
//  NWHotViewCacheBean.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotViewCacheBean.h"

@implementation NWHotViewCacheBean

-(id)init {
    self = [super init];
    if (self) {
        self.appListArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.bannerListArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

-(void)assemblyViewCacheBean:(NSDictionary *)dic {
    [self.appListArray removeAllObjects];
    NSString *code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    if ([code isEqualToString:@"1000"]) {
        NSArray *apps = (NSArray *)[[[dic objectForKey:@"data"] objectForKey:@"apps"] objectForKey:@"data"];
        for (id obj in apps) {
            NSDictionary *app = (NSDictionary *)obj;
            NWListAppModel *model = [[NWListAppModel alloc]init];
            model.appTrackName = [NSString stringWithFormat:@"%@",[app objectForKey:@"trackName"]];
            model.appIcon = [NSString stringWithFormat:@"%@",[app objectForKey:@"icon"]];
            model.appID = [NSString stringWithFormat:@"%@",[app objectForKey:@"ID"]];
            model.appRating = [NSString stringWithFormat:@"%@",[app objectForKey:@"averageUserRating"]];
            model.appVersion = [NSString stringWithFormat:@"%@",[app objectForKey:@"version"]];
            model.appSize = [NSString stringWithFormat:@"%@",[app objectForKey:@"size"]];
            model.appSort = [NSString stringWithFormat:@"%@",[app objectForKey:@"sort"]];
            [self.appListArray addObject:model];
        }
        NSArray *sliders = (NSArray *)[[dic objectForKey:@"data"] objectForKey:@"slider"];
        for (id obj in sliders) {
            NSDictionary *slider = (NSDictionary *)obj;
            NWBannerModel *model = [[NWBannerModel alloc]init];
            model.url =[NSString stringWithFormat:@"%@",[slider objectForKey:@"picURL"]];
            model.appID =[NSString stringWithFormat:@"%@",[slider objectForKey:@"link"]];
            model.title =[NSString stringWithFormat:@"%@",[slider objectForKey:@"title"]];
            [self.bannerListArray addObject:model];
        }
    }
}

@end
