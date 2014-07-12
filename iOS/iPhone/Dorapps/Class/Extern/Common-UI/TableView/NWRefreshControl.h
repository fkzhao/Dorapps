//
//  NWRefreshControl.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWHeaderStateView.h"
#import "NWFooterStateView.h"
@class NWTableView;

@protocol NWTableViewDelegate <NSObject>

@optional

- (void)pullDownToRefreshData:(NWTableView *)tableView;

- (void)pullUpToAddData:(NWTableView *)tableView;

- (void)pullDownToRefreshWillBegin:(NWTableView *)tableView;

@end;


@interface NWRefreshControl : NSObject<UIScrollViewDelegate>

@property (nonatomic,assign) UIScrollView *scrollView;
@property (nonatomic,strong) NWHeaderStateView *headerView;
@property (nonatomic,strong) NWFooterStateView *footerView;

-(instancetype)initWithScrollView:(UIScrollView *)scrollView;

-(void)setTableViewStatus:(ePullStateType)state;
@end
