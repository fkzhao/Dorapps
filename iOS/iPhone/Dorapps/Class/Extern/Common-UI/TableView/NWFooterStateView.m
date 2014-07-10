//
//  NWFooterStateView.m
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWFooterStateView.h"
#import "NWActivityIndicatorView.h"

@interface NWFooterStateView ()

@property (nonatomic, strong) NWActivityIndicatorView *activityIndicatorView;

@end
@implementation NWFooterStateView

- (void)startLoading {
    self.hidden = NO;
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:@"正在加载" forState:UIControlStateNormal];
    [self.activityIndicatorView startAnimating];
}

- (void)endLoading {
    self.hidden = YES;
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
    [self.activityIndicatorView stopAnimating];
}

- (void)configuraManualState {
    self.hidden = NO;
    self.loadMoreButton.userInteractionEnabled = YES;
    [self.loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
}

- (void)configuraNothingMoreWithMessage:(NSString *)message {
    self.hidden = NO;
    self.loadMoreButton.userInteractionEnabled = NO;
    [self.loadMoreButton setTitle:message forState:UIControlStateNormal];
}

#pragma mark - Propertys

- (UIButton *)loadMoreButton {
    if (!_loadMoreButton) {
        _loadMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 10)];
        _loadMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loadMoreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loadMoreButton setBackgroundColor:[UIColor colorWithWhite:0.922 alpha:1.000]];
    }
    return _loadMoreButton;
}

- (NWActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[NWActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _activityIndicatorView.color = NWColorRGB(70, 154, 233);
        _activityIndicatorView.hidesWhenStopped = YES;
        _activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.bounds) / 3, CGRectGetHeight(self.bounds) / 2.0);
    }
    return _activityIndicatorView;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.loadMoreButton];
        [self addSubview:self.activityIndicatorView];
        [self endLoading];
    }
    return self;
}

@end
