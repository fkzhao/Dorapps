//
//  NWHotSender.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWSender.h"

@interface NWHotSender : NWSender

-(NWSenderResultModel *)sendGetHotAppList;

-(NWSenderResultModel *)sendGetMoreHotApps:(NSInteger)page;

-(NWSenderResultModel *)sendRefreshHotAppList;

-(NWSenderResultModel *)sendGetAppDetail:(NSString *)appID;
@end
