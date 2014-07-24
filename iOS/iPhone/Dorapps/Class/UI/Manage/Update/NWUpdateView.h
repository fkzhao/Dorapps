//
//  NWUpdateView.h
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWRootView.h"
#import "NWUpdateViewCacheBean.h"
#import "NWTableView.h"

typedef void (^uploadBlock) ();
@interface NWUpdateView : NWRootView

@property (nonatomic,copy) uploadBlock updateBlock;
@property (nonatomic,strong)NWTableView *mainTableView;
@property (nonatomic,strong)NWUpdateViewCacheBean *cacheBean;
-(void)updateAllApps;
@end
