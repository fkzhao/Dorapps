//
//  NWHotViewCacheBean.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWViewCacheBean.h"
#import "NWListAppModel.h"
#import "NWBannerModel.h"

@interface NWHotViewCacheBean : NWViewCacheBean

@property (nonatomic,strong) NSMutableArray *appListArray;
@property (nonatomic,strong) NSMutableArray *bannerListArray;

@end
