//
//  NWDetailViewCacheBean.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDetailViewCacheBean.h"

@implementation NWDetailViewCacheBean

-(id)init
{
    self = [super init];
    if (self) {
        self.appID = @"";
        self.appInfo =  [[NWDetailInfoModel alloc]init];
        self.interestList =  [[NSMutableArray alloc]initWithCapacity:0];
        self.appIntroduct =  [[NWDetailIntroductModel alloc]init];
        self.historyVersionList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

-(void)assemblyViewCacheBean:(NSDictionary *)dic
{
    if ([dic objectForKey:@"data"]) {
        NSDictionary *app = (NSDictionary *)[dic objectForKey:@"data"];
        self.appID = [NSString stringWithFormat:@"%@",[app objectForKey:@"ID"]];
        
        self.appInfo.appIcon = [NSString stringWithFormat:@"%@",[app objectForKey:@"icon"]];
        self.appInfo.appRating = [NSString stringWithFormat:@"%@",[app objectForKey:@"averageUserRating"]];
        self.appInfo.appName = [NSString stringWithFormat:@"%@",[app objectForKey:@"trackName"]];
        self.appInfo.appVersion = [NSString stringWithFormat:@"%@",[app objectForKey:@"version"]];
        self.appInfo.appSize = [NSString stringWithFormat:@"%@",[app objectForKey:@"size"]];
        self.appInfo.appReleaseNote = [NSString stringWithFormat:@"%@",[app objectForKey:@"releaseNotes"]];
        
        NSArray *screenShots = (NSArray *)[app objectForKey:@"ipadScreenshotUrls"];
        for (id url in screenShots) {
            [self.appIntroduct.screenShots addObject:[NSString stringWithFormat:@"%@",url]];
        }
        self.appIntroduct.descriptionInfo = [NSString stringWithFormat:@"%@",[app objectForKey:@"description"]];
        
        //组装历史版本
        NSDictionary *historyDic = (NSDictionary *)[[app objectForKey:@"ipaHistoryDownloads"] objectForKey:@"jb"];
        NSArray *keys = [historyDic allKeys];
        for (NSString *key in keys) {
            NWAppHistoryModel *model = [[NWAppHistoryModel alloc]init];
            model.iconUrl = [NSString stringWithFormat:@"%@",[app objectForKey:@"icon"]];
            model.version = key;
            [self.historyVersionList addObject:model];
        }
        [self.historyVersionList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NWAppHistoryModel *key1 = (NWAppHistoryModel *)obj1;
            NWAppHistoryModel *key2 = (NWAppHistoryModel *)obj2;
            NSComparisonResult result = [key1.version compare:key2.version];
            return result == NSOrderedAscending;  // 降序
        }];
        
    }
}

@end
