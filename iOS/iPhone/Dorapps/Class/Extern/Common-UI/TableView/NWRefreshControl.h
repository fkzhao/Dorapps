//
//  NWRefreshControl.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NWRefreshViewLayerType) {
    NWRefreshViewLayerTypeOnScrollViews = 0,
    NWRefreshViewLayerTypeOnSuperView = 1,
};

@protocol NWRefreshControlDelegate <NSObject>

@required
/**
 *  1、这个是用于标识用户是否在加载数据中，所以涉及到业务逻辑的问题，所以就外部传值
 *
 *  @return 如果不实现该delegate方法，所以效果都会实现
 */
- (BOOL)isLoading;

/**
 *  2、将要开始下拉刷新的方法
 */
- (void)beginPullDownRefreshing;

/**
 *  3、将要开始上提加载更多的方法
 */
- (void)beginLoadMoreRefreshing;

/**
 *  4、最后更新数据的时间
 *
 *  @return 返回缓存最后更新某个页面的时间
 */
- (NSDate *)lastUpdateTime;

@optional
/**
 *  1、是否支持下拉刷新
 *
 *  @return 如果没有实现该delegate方法，默认是支持下拉的，为YES
 */
- (BOOL)isPullDownRefreshed;

/**
 *  2、是否支持上提加载更多
 *
 *  @return 如果没有实现该delegate方法，默认是支持上提加载更多的，为YES
 */
- (BOOL)isLoadMoreRefreshed;

/**
 *  3、标识下拉刷新是UIScrollView的子view，还是UIScrollView父view的子view
 *
 *  @return 如果没有实现该delegate方法，默认是scrollView的子View，为XHRefreshViewLayerTypeOnScrollViews
 */
- (NWRefreshViewLayerType)refreshViewLayerType;

/**
 *  4、UIScrollView的控制器是否保留iOS7新的特性，意思是：tablView的内容是否可以穿透过导航条
 *
 *  @return 如果不是先该delegate方法，默认是不支持的
 */
- (BOOL)keepiOS7NewApiCharacter;

/**
 *  5、将自动加载更多的状态转换为手动加载需要的条件，现在是加载更多多少次后，开始转换
 *
 *  @return 如果不实现该delegate方法，默认是5次
 */
- (NSInteger)autoLoadMoreRefreshedCountConverManual;

@end

@interface NWRefreshControl : NSObject

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <NWRefreshControlDelegate>)delegate;

/**
 *  外部手动启动下拉加载的方法，这个方法不需要手动去拖动UIScrollView
 */
- (void)startPullDownRefreshing;

/**
 *  停止下拉刷新的方法
 */
- (void)endPullDownRefreshing;

/**
 *  停止上提加载更多的方法
 */
- (void)endLoadMoreRefresing;

/**
 *  没有更多的数据加载
 */
- (void)endMoreOverWithMessage:(NSString *)message;

@end
