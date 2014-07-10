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

@class NWTableView;

@protocol NWTableViewDelegate <NSObject>

@optional
/**
 下拉刷新回调
 
 @param tableView 列表视图对象
 */
- (void)pullDownToRefreshData:(NWTableView *)tableView;
/**
 上拉加载回调
 
 @param tableView 列表视图对象
 */
- (void)pullUpToAddData:(NWTableView *)tableView;

/**
 *  下拉刷新即将开始
 *
 *  @param tableView 列表视图对象
 */
- (void)pullDownToRefreshWillBegin:(NWTableView *)tableView;

@end


@interface NWTableView : UITableView {
    BOOL isInited;
    
    NWHeaderStateView *headerView_;
    NWFooterStateView *footerView_;
}

/** header加载提示视图 */
@property (nonatomic, strong)  NWHeaderStateView *headerView;
/** footerView加载提示视图 */
@property (nonatomic, strong)  NWFooterStateView *footerView;
/** delegate */
@property (nonatomic, assign)  IBOutlet id<NWTableViewDelegate>updateDelegate;

- (void)startPullDownRefreshing;

- (void)endPullDownRefreshing;

- (void)endLoadMoreRefreshing;

- (void)endMoreOverWithMessage:(NSString *)message;
/**
 更新视图
 
 @param isAllLoaded 数据是否全部加载完
 */
- (void)reloadDataWithLoadMoreIsAllLoaded:(BOOL)isAllLoaded;
/**
 更新视图
 
 @param isAllLoaded 数据是否全部加载完
 @param message 底部显示信息
 */
- (void)reloadDataWithLoadMoreIsAllLoaded:(BOOL)isAllLoaded withMessage:(NSString *)message;
/**
 更新视图
 
 @param nil
 */
- (void)reloadDataWithRefreshingIsAllLoaded:(BOOL)isAllLoaded;
@end
