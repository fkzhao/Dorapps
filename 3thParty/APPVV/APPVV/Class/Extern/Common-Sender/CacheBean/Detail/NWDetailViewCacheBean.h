//
//  NWDetailViewCacheBean.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "CTViewCacheBean.h"
#import "NWDetailInfoModel.h"
#import "NWDetailIntroductModel.h"
#import "NWDtailInterestModel.h"
#import "NWAppHistoryModel.h"

@interface NWDetailViewCacheBean :CTViewCacheBean

@property (nonatomic,strong) NSString *appID;

@property (nonatomic,strong) NWDetailInfoModel *appInfo;
@property (nonatomic,strong) NSMutableArray *interestList;
@property (nonatomic,strong) NWDetailIntroductModel *appIntroduct;

@property (nonatomic,strong) NSMutableArray *historyVersionList;

@end
