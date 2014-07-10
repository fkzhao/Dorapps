//
//  NWTableView.m
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWTableView.h"
#import "NWRefreshControl.h"
@interface NWTableView ()<NWRefreshControlDelegate>
{
    NWRefreshControl *refreshControl_;
}

@property (nonatomic,strong) NWRefreshControl *refreshControl;
@property (nonatomic, assign) BOOL isDataLoading;
@end

@implementation NWTableView
@synthesize refreshControl = refreshControl_;
@synthesize headerView = headerView_;
@synthesize footerView = footerView_;

#pragma mark - --------------------退出清空--------------------

#pragma mark - --------------------初始化--------------------

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseData];
        [self initBaseView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initBaseData];
        [self initBaseView];
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)initBaseData {
    
}

-(void)initBaseView {
    if (!refreshControl_) {
        refreshControl_ =  [[NWRefreshControl alloc] initWithScrollView:self delegate:self];
    }
    
}

#pragma mark - NWRefreshControl Delegate

- (BOOL)isLoading {
    return self.isDataLoading;
}

- (void)beginPullDownRefreshing {
    if (self.updateDelegate && [self.updateDelegate respondsToSelector:@selector(pullDownToRefreshData:)]) {
        [self.updateDelegate pullDownToRefreshData:self];
    }
}

- (void)beginLoadMoreRefreshing {
    if (self.updateDelegate && [self.updateDelegate respondsToSelector:@selector(pullUpToAddData:)]) {
        [self.updateDelegate pullUpToAddData:self];
    }
}

- (NSDate *)lastUpdateTime {
    return [NSDate date];
}

- (BOOL)keepiOS7NewApiCharacter {
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

- (NSInteger)autoLoadMoreRefreshedCountConverManual {
    return 2;
}

- (BOOL)isPullDownRefreshed {
    return YES;
}

- (BOOL)isLoadMoreRefreshed {
    return NO;
}

- (NWRefreshViewLayerType)refreshViewLayerType {
    return NWRefreshViewLayerTypeOnScrollViews;
}

#pragma mark - private method 
- (void)startPullDownRefreshing {
    [self.refreshControl startPullDownRefreshing];
}

- (void)endPullDownRefreshing {
    [self.refreshControl endPullDownRefreshing];
}

- (void)endLoadMoreRefreshing {
    [self.refreshControl endLoadMoreRefresing];
}

- (void)endMoreOverWithMessage:(NSString *)message {
    [self.refreshControl endMoreOverWithMessage:message];
}

#pragma mark - API Method 
/**
 更新视图
 
 @param isAllLoaded 数据是否全部加载完
 */
- (void)reloadDataWithLoadMoreIsAllLoaded:(BOOL)isAllLoaded {
    [self reloadDataWithLoadMoreIsAllLoaded:isAllLoaded withMessage:nil];
}
/**
 更新视图
 
 @param isAllLoaded 数据是否全部加载完
 @param message 底部显示信息
 */
- (void)reloadDataWithLoadMoreIsAllLoaded:(BOOL)isAllLoaded withMessage:(NSString *)message {
    if (message) {
        [self endMoreOverWithMessage:message];
    } else {
        [self endLoadMoreRefreshing];
    }
    [self reloadData];
}
/**
 更新视图
 
 @param nil
 */
- (void)reloadDataWithRefreshingIsAllLoaded:(BOOL)isAllLoaded {
    [self endPullDownRefreshing];
    [self reloadData];
}
@end
