//
//  NWRefreshControl.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWRefreshControl.h"

#import "NWHeaderStateView.h"
#import "NWFooterStateView.h"

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

#define kXHDefaultRefreshTotalPixels 60

#define kXHAutoLoadMoreRefreshedCount 5


typedef NS_ENUM(NSInteger, NWRefreshState) {
    NWRefreshStatePulling   = 0,
    NWRefreshStateNormal    = 1,
    NWRefreshStateLoading   = 2,
    NWRefreshStateStopped   = 3,
};

@interface NWRefreshControl ()

@property (nonatomic, weak) id <NWRefreshControlDelegate> delegate;

// getter
@property (nonatomic, strong) NWHeaderStateView *refreshView;
@property (nonatomic, strong) NWFooterStateView *loadMoreView;
@property (nonatomic, assign) BOOL isPullDownRefreshed;
@property (nonatomic, assign) BOOL isLoadMoreRefreshed;
@property (nonatomic, assign) CGFloat refreshTotalPixels;
@property (nonatomic, assign) NSInteger autoLoadMoreRefreshedCount;
@property (nonatomic, assign) NWRefreshViewLayerType refreshViewLayerType;

@property (nonatomic, readwrite) CGFloat originalTopInset;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NWRefreshState refreshState;

@property (nonatomic, assign) NSInteger loadMoreRefreshedCount;
@property (nonatomic, assign) BOOL pullDownRefreshing;
@property (nonatomic, assign) BOOL loadMoreRefreshing;

@property (nonatomic, assign) BOOL noMoreDataForLoaded;

@end

@implementation NWRefreshControl

#pragma mark - Pull Down Refreshing Method

- (void)startPullDownRefreshing {
    if (self.isPullDownRefreshed) {
        self.pullDownRefreshing = YES;
        
        NSDate *date = [self.delegate lastUpdateTime];
        if ([date isKindOfClass:[NSDate class]] || date) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            
            NSString *destDateString = [dateFormatter stringFromDate:date];
            self.refreshView.timeLabel.text = [NSString stringWithFormat:@"上次刷新：%@", destDateString];
        }
        
        self.refreshState = NWRefreshStatePulling;
        
        self.refreshState = NWRefreshStateLoading;
    }
}

- (void)animationRefreshCircleView {
    if (self.refreshView.refreshCircleView.offsetY != kXHDefaultRefreshTotalPixels - kXHRefreshCircleViewHeight) {
        self.refreshView.refreshCircleView.offsetY = kXHDefaultRefreshTotalPixels - kXHRefreshCircleViewHeight;
        [self.refreshView.refreshCircleView setNeedsDisplay];
    }
    // 先去除所有动画
    [self.refreshView.refreshCircleView.layer removeAllAnimations];
    // 添加旋转的动画
    [self.refreshView.refreshCircleView.layer addAnimation:[NWRefreshCircleView repeatRotateAnimation] forKey:@"rotateAnimation"];
    
    [self callBeginPullDownRefreshing];
}

- (void)callBeginPullDownRefreshing {
    self.loadMoreRefreshedCount = 0;
    self.noMoreDataForLoaded = NO;
    
    [self.delegate beginPullDownRefreshing];
}

- (void)endPullDownRefreshing {
    if (self.isPullDownRefreshed) {
        self.pullDownRefreshing = NO;
        self.refreshState = NWRefreshStateStopped;
        
        [self resetScrollViewContentInset];
    }
}

#pragma mark - Load More Refreshing Method

- (void)startLoadMoreRefreshing {
    if (self.isLoadMoreRefreshed) {
        if (self.loadMoreRefreshedCount < self.autoLoadMoreRefreshedCount) {
            [self callBeginLoadMoreRefreshing];
        } else {
            [self.loadMoreView configuraManualState];
        }
    }
}

- (void)callBeginLoadMoreRefreshing {
    if (self.loadMoreRefreshing)
        return;
    self.loadMoreRefreshing = YES;
    self.loadMoreRefreshedCount ++;
    self.refreshState = NWRefreshStateLoading;
    [self.loadMoreView startLoading];
    [self.delegate beginLoadMoreRefreshing];
}

- (void)endLoadMoreRefresing {
    if (self.isLoadMoreRefreshed) {
        self.loadMoreRefreshing = NO;
        self.refreshState = NWRefreshStateNormal;
        [self.loadMoreView endLoading];
    }
}

- (void)loadMoreButtonClciked:(UIButton *)sender {
    [self callBeginLoadMoreRefreshing];
}

- (void)endMoreOverWithMessage:(NSString *)message {
    self.noMoreDataForLoaded = YES;
    [self.loadMoreView configuraNothingMoreWithMessage:message];
}

#pragma mark - Scroll View

- (void)resetScrollViewContentInset {
    UIEdgeInsets contentInset = self.scrollView.contentInset;
    contentInset.top = self.originalTopInset;
    [UIView animateWithDuration:0.3f animations:^{
        [self.scrollView setContentInset:contentInset];
    } completion:^(BOOL finished) {
        
        self.refreshState = NWRefreshStateNormal;
        
        self.refreshView.refreshCircleView.offsetY = 0;
        [self.refreshView.refreshCircleView setNeedsDisplay];
        
        if (self.refreshView.refreshCircleView) {
            [self.refreshView.refreshCircleView.layer removeAllAnimations];
        }
    }];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.contentInset = contentInset;
                     }
                     completion:^(BOOL finished) {
                         if (self.refreshState == NWRefreshStateStopped) {
                             self.refreshState = NWRefreshStateNormal;
                             
                             if (self.refreshView.refreshCircleView) {
                                 [self.refreshView.refreshCircleView.layer removeAllAnimations];
                             }
                         }
                     }];
}

- (void)setScrollViewContentInsetForLoading {
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.refreshTotalPixels;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForLoadMore {
    if (self.pullDownRefreshing)
        return;
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = kXHLoadMoreViewHeight;
    [self setScrollViewContentInset:currentInsets];
}

#pragma mark - Propertys

- (NWHeaderStateView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[NWHeaderStateView alloc] initWithFrame:CGRectMake(0, (self.refreshViewLayerType == NWRefreshViewLayerTypeOnScrollViews ? -kXHDefaultRefreshTotalPixels : self.originalTopInset), CGRectGetWidth([[UIScreen mainScreen] bounds]), kXHDefaultRefreshTotalPixels)];
        _refreshView.backgroundColor = [UIColor clearColor];
        _refreshView.refreshCircleView.heightBeginToRefresh = kXHDefaultRefreshTotalPixels - kXHRefreshCircleViewHeight;
        _refreshView.refreshCircleView.offsetY = 0;
        _refreshView.refreshCircleView.isRefreshViewOnTableView = self.refreshViewLayerType;
    }
    return _refreshView;
}

- (NWFooterStateView *)loadMoreView {
    if (!_loadMoreView) {
        _loadMoreView = [[NWFooterStateView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), kXHLoadMoreViewHeight)];
        [_loadMoreView.loadMoreButton addTarget:self action:@selector(loadMoreButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadMoreView;
}

#pragma mark - Getter Method

- (BOOL)isLoading {
    return [self.delegate isLoading];
}

- (BOOL)isPullDownRefreshed {
    BOOL pullDowned = YES;
    if ([self.delegate respondsToSelector:@selector(isPullDownRefreshed)]) {
        pullDowned = [self.delegate isPullDownRefreshed];
        return pullDowned;
    }
    return YES;
}

- (BOOL)isLoadMoreRefreshed {
    BOOL loadMored = YES;
    if ([self.delegate respondsToSelector:@selector(isLoadMoreRefreshed)]) {
        loadMored = [self.delegate isLoadMoreRefreshed];
        return loadMored;
    }
    return loadMored;
}

- (CGFloat)refreshTotalPixels {
    return kXHDefaultRefreshTotalPixels + [self getAdaptorHeight];
}

- (CGFloat)getAdaptorHeight {
    return 0;
    if ([self.delegate respondsToSelector:@selector(keepiOS7NewApiCharacter)]) {
        return ([self.delegate keepiOS7NewApiCharacter] ? 64 : 0);
    } else {
        return 0;
    }
}

- (NSInteger)autoLoadMoreRefreshedCount {
    if ([self.delegate respondsToSelector:@selector(autoLoadMoreRefreshedCountConverManual)]) {
        return [self.delegate autoLoadMoreRefreshedCountConverManual];
    }
    return kXHAutoLoadMoreRefreshedCount;
}

- (NWRefreshViewLayerType)refreshViewLayerType {
    NWRefreshViewLayerType currentRefreshViewLayerType = NWRefreshViewLayerTypeOnScrollViews;
    if ([self.delegate respondsToSelector:@selector(refreshViewLayerType)]) {
        currentRefreshViewLayerType = [self.delegate refreshViewLayerType];
    }
    return currentRefreshViewLayerType;
}

#pragma mark - Setter Method

- (void)setRefreshState:(NWRefreshState)refreshState {
    switch (refreshState) {
        case NWRefreshStateStopped:
        case NWRefreshStateNormal: {
            self.refreshView.stateLabel.text = @"下拉刷新";
            break;
        }
        case NWRefreshStateLoading: {
            
            if (self.pullDownRefreshing) {
                self.refreshView.stateLabel.text = @"正在加载";
                [self setScrollViewContentInsetForLoading];
                
                if(_refreshState == NWRefreshStatePulling) {
                    [self animationRefreshCircleView];
                }
            }
            break;
        }
        case NWRefreshStatePulling:
            self.refreshView.stateLabel.text = @"释放立即刷新";
            break;
        default:
            break;
    }
    
    _refreshState = refreshState;
}

#pragma mark - Life Cycle

- (void)configuraObserverWithScrollView:(UIScrollView *)scrollView {
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
    [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverWithScrollView:(UIScrollView *)scrollView {
    [scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [scrollView removeObserver:self forKeyPath:@"contentInset" context:nil];
    [scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

- (void)setup {
    self.originalTopInset = self.scrollView.contentInset.top;
    
    
    self.refreshState = NWRefreshStateNormal;
    
    [self configuraObserverWithScrollView:self.scrollView];
    
    if (self.refreshViewLayerType == NWRefreshViewLayerTypeOnSuperView) {
        self.scrollView.backgroundColor = [UIColor clearColor];
        UIView *currentSuperView = self.scrollView.superview;
        if (self.isPullDownRefreshed) {
            [currentSuperView insertSubview:self.refreshView belowSubview:self.scrollView];
        }
    } else if (self.refreshViewLayerType == NWRefreshViewLayerTypeOnScrollViews) {
        if (self.isPullDownRefreshed) {
            [self.scrollView addSubview:self.refreshView];
        }
    }
    
    
    if (self.isLoadMoreRefreshed) {
        [self.scrollView addSubview:self.loadMoreView];
    }
}

- (id)initWithScrollView:(UIScrollView *)scrollView delegate:(id <NWRefreshControlDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.scrollView = scrollView;
        [self setup];
    }
    return self;
}

- (void)dealloc {
    self.delegate = nil;
    [self removeObserverWithScrollView:self.scrollView];
    self.scrollView = nil;
    
    self.refreshView = nil;
    
    self.loadMoreView = nil;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        
        if (self.isLoadMoreRefreshed) {
            // 上提加载更多的逻辑方法
            int currentPostion = contentOffset.y;
            
            if (currentPostion > 0) {
                
                CGRect bounds = self.scrollView.bounds;//边界
                
                CGSize size = self.scrollView.contentSize;//滚动视图内容区域size
                
                UIEdgeInsets inset = self.scrollView.contentInset;//视图周围额外的滚动视图区域
                
                float y = currentPostion + bounds.size.height + inset. bottom;
                
                //判断是否滚动到底部
                if((y - size.height) > kXHLoadMoreViewHeight && self.refreshState != NWRefreshStateLoading && self.isLoadMoreRefreshed && !self.loadMoreRefreshing && !self.noMoreDataForLoaded) {
                    [self startLoadMoreRefreshing];
                }
            }
        }
        
        if (self.isPullDownRefreshed) {
            if (!self.loadMoreRefreshing) {
                // 下拉刷新的逻辑方法
                if(self.refreshState != NWRefreshStateLoading) {
                    // 如果不是加载状态的时候
                    
                    if (ABS(self.scrollView.contentOffset.y + [self getAdaptorHeight]) >= kXHRefreshCircleViewHeight) {
                        self.refreshView.refreshCircleView.offsetY = MIN(ABS(self.scrollView.contentOffset.y + [self getAdaptorHeight]), kXHDefaultRefreshTotalPixels) - kXHRefreshCircleViewHeight;
                        [self.refreshView.refreshCircleView setNeedsDisplay];
                    }
                    
                    CGFloat scrollOffsetThreshold;
                    scrollOffsetThreshold = -(kXHDefaultRefreshTotalPixels + self.originalTopInset);
                    
                    if(!self.scrollView.isDragging && self.refreshState == NWRefreshStatePulling) {
                        self.pullDownRefreshing = YES;
                        self.refreshState = NWRefreshStateLoading;
                    } else if(contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging && self.refreshState == NWRefreshStateStopped) {
                        self.refreshState = NWRefreshStatePulling;
                    } else if(contentOffset.y >= scrollOffsetThreshold && self.refreshState != NWRefreshStateStopped) {
                        self.refreshState = NWRefreshStateStopped;
                    }
                } else {
                    CGFloat offset;
                    UIEdgeInsets contentInset;
                    offset = MAX(self.scrollView.contentOffset.y * -1, 0.0f);
                    offset = MIN(offset, self.refreshTotalPixels);
                    offset = 60;
                    contentInset = self.scrollView.contentInset;
                    self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
                }
            }
        }
    } else if ([keyPath isEqualToString:@"contentInset"]) {
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        if (self.isLoadMoreRefreshed && !self.noMoreDataForLoaded) {
            CGSize contentSize = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue];
            if (contentSize.height > CGRectGetHeight(self.scrollView.frame)) {
                CGRect loadMoreViewFrame = self.loadMoreView.frame;
                loadMoreViewFrame.origin.y = contentSize.height;
                self.loadMoreView.frame = loadMoreViewFrame;
                [self setScrollViewContentInsetForLoadMore];
            }
        }
    }
}


@end
