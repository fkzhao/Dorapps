//
//  NWUpdateViewCacheBean.h
//  CoreBusiness
//
//  Created by Anselz on 14-7-24.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWViewCacheBean.h"

@interface NWUpdateAppModel : NSObject

@property (nonatomic,strong) NSString *appName;
@property (nonatomic,strong) NSString *appDownloadURL;
@property (nonatomic,strong) NSString *appVersion;
@property (nonatomic,strong) NSString *appIcon;
@property (nonatomic,strong) NSString *appSize;

@end


@interface NWUpdateViewCacheBean : NWViewCacheBean

@property (nonatomic,strong) NSMutableArray *appListArray;

@end
