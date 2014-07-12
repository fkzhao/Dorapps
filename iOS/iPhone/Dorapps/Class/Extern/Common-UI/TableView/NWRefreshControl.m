//
//  NWRefreshControl.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWRefreshControl.h"
#import "NWTableView.h"

@implementation NWRefreshControl

-(instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        [self initBaseData];
        [self initBaseView];
    }
    return self;
}

-(void)initBaseData
{
//    self.scrollView.delegate = self;
    [self registObserverWithScrollView:self.scrollView];
}

-(void)initBaseView
{
    if (nil == _headerView) {
        _headerView = [[NWHeaderStateView alloc]initWithFrame:CGRectMake(0, -60, 320, 60)];
        [_scrollView addSubview:_headerView];
    }
    if (nil == _footerView) {
        _footerView = [[NWFooterStateView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight([[UIScreen mainScreen] bounds]), CGRectGetWidth([[UIScreen mainScreen] bounds]), 50)];
        if ([_scrollView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)_scrollView;
            tableView.tableFooterView = _footerView;
        }
    }
}
- (void)registObserverWithScrollView:(UIScrollView *)scrollView {
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
    [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [scrollView addObserver: self
                 forKeyPath: @"pan.state"
                    options: NSKeyValueObservingOptionNew
                    context: nil];
}

- (void)removeObserverWithScrollView:(UIScrollView *)scrollView {
    [scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [scrollView removeObserver:self forKeyPath:@"contentInset" context:nil];
    [scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    [scrollView removeObserver:self forKeyPath:@"pan.state" context:nil];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"pan.state"]) {
        NSInteger state = [[change valueForKey:NSKeyValueChangeNewKey] integerValue];
        if (state  == UIGestureRecognizerStateEnded) {
            ePullActionType returnKey = [self scrollViewDidEndDragging:self.scrollView];
            NSTimeInterval animationTime = fabs(self.scrollView.contentOffset.y / 800);
            if (_headerView.state == ePullStateTypeRefresh) {
                [UIView animateWithDuration:animationTime animations:^(void){
                    [self.scrollView setContentInset:UIEdgeInsetsMake(_headerView.bounds.size.height, 0, 0, 0)];
                }] ;
            }
            [self startUpdateWithKey:returnKey];
        }
    }
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGFloat offsetY = contentOffset.y ;
        [self.headerView setOffSetY:offsetY];
        if (_headerView.state == ePullStateTypeRefresh ||
            _footerView.state == ePullStateTypeLoadMore) {
            return;
        }
        if (offsetY < -_headerView.bounds.size.height) {
            [_headerView changeState:ePullStateTypeDown];
        } else {
            [_headerView changeState:ePullStateTypeNormal];
        }
        if (ePullStateTypeEnd == _footerView.state) {
            return;
        }
        
        CGFloat differenceY = self.scrollView.contentSize.height > self.scrollView.frame.size.height ? (self.scrollView.contentSize.height - self.scrollView.frame.size.height) : 0;
        if (offsetY > differenceY + _footerView.bounds.size.height / 3 * 2) {
            [_footerView changeState:ePullStateTypeUp];
        } else {
            [_footerView changeState:ePullStateTypeNormal];
        }
    } else if ([keyPath isEqualToString:@"contentInset"]) {
        
    } else if ([keyPath isEqualToString:@"contentSize"]) {
        
    }
}


-(void)dealloc
{
    [self removeObserverWithScrollView:self.scrollView];
    [self.scrollView setDelegate:nil];
}


#pragma mark 当表视图结束拖动时的执行方法
- (ePullActionType)scrollViewDidEndDragging:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (_headerView.state == ePullStateTypeRefresh ||
        _headerView.state == ePullStateTypeLoadMore) {
        return ePullActionTypeDoNothing;
    }
    
    if (!_headerView.hidden && offsetY < -_headerView.bounds.size.height) {
        NWTableView *tabeView = nil;
        if ([self.scrollView isKindOfClass:[NWTableView class]]) {
            tabeView = (NWTableView *)self.scrollView;
        }
        if (tabeView.updateDelegate && [tabeView.updateDelegate  respondsToSelector:@selector(pullDownToRefreshWillBegin:)])
		{
			[tabeView.updateDelegate performSelector:@selector(pullDownToRefreshWillBegin:) withObject:self];
		}
        [_headerView changeState:ePullStateTypeRefresh];
        
        return ePullActionTypeRefresh;
    }
    
    CGFloat differenceY = self.scrollView.contentSize.height > self.scrollView.frame.size.height ? (self.scrollView.contentSize.height - self.scrollView.frame.size.height) : 0;
    if (!_footerView.hidden && _footerView.state != ePullStateTypeEnd &&
        offsetY > differenceY + _footerView.bounds.size.height / 3 * 2) {
        [_footerView changeState:ePullStateTypeLoadMore];
        return ePullActionTypeLoadMore;
    }
    return ePullActionTypeDoNothing;
}

- (void)startUpdateWithKey:(ePullActionType)key
{
    if (key != ePullActionTypeDoNothing) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.scrollView, @"TableObject", [NSString stringWithFormat:@"%d", key], @"ReturnKey", nil];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateCTTableViewThread:) object:userInfo];
        [self performSelectorOnMainThread:@selector(updateCTTableViewThread:) withObject:userInfo waitUntilDone:NO];
    }
}

#pragma mark 更新线程
- (void)updateCTTableViewThread:(NSDictionary *)dictionary
{
    NWTableView *theTableView = [dictionary objectForKey:@"TableObject"];
    ePullActionType returnKey = (ePullActionType)[[dictionary objectForKey:@"ReturnKey"] intValue];
    NSObject *theUpdateDelegate = theTableView.updateDelegate;
    
    switch (returnKey) {
        case ePullActionTypeRefresh:
            if (theUpdateDelegate && [theUpdateDelegate respondsToSelector:@selector(pullDownToRefreshData:)]) {
                [theUpdateDelegate performSelectorOnMainThread:@selector(pullDownToRefreshData:) withObject:theTableView waitUntilDone:NO];
            }
            break;
            
        case ePullActionTypeLoadMore:
            if (theUpdateDelegate && [theUpdateDelegate respondsToSelector:@selector(pullUpToAddData:)]) {
                [theUpdateDelegate performSelectorOnMainThread:@selector(pullUpToAddData:) withObject:theTableView waitUntilDone:NO];
            }
            break;
            
        default:
            break;
    }
}


-(void)setTableViewStatus:(ePullStateType)state
{
    if (state == ePullStateTypeRefresh) {
        [self.headerView changeState:state];
        self.headerView.stateLabel.text = @"加载中";
        [UIView animateWithDuration:0.5 animations:^(void){
            [self.scrollView setContentInset:UIEdgeInsetsMake(_headerView.bounds.size.height, 0, 0, 0)];
        }] ;
        
    }
}
@end
