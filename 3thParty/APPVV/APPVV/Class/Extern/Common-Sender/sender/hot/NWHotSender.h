//
//  NWHotSender.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "CTSender.h"

@interface NWHotSender : CTSender

-(CTSenderResultModel *)sendGetHotAppList;

-(CTSenderResultModel *)sendGetMoreHotApps:(NSInteger)page;

-(CTSenderResultModel *)sendRefreshHotAppList;

-(CTSenderResultModel *)sendGetAppDetail:(NSString *)appID;
@end
