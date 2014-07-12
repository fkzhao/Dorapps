//
//  NWTableView.h
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWTableViewDefine.h"
#import "NWHeaderStateView.h"
#import "NWFooterStateView.h"
#import "NWTableViewCellUtil.h"
#import "NWRefreshControl.h"

@interface NWTableView : UITableView {

}

/** delegate */
@property (nonatomic, assign)  IBOutlet id<NWTableViewDelegate>updateDelegate;


-(void)setTableViewStateRefreshing;
- (void)reloadDataWithIsAllLoaded:(BOOL)isAllLoaded;
@end
