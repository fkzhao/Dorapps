//
//  NWFooterStateView.m
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWFooterStateView.h"
#import "NWActivityIndicatorView.h"
#import "NWActivityIndicatorView.h"
@interface NWFooterStateView ()

@property (nonatomic, strong) NWActivityIndicatorView *activityIndicatorView;

@end

@implementation NWFooterStateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseView];
        
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseView];
}

-(void)initBaseView
{
    if (self.stateLabel) {
        self.stateLabel.text = @"上拉加载更多";
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.font = [UIFont systemFontOfSize:15];
    }
    if (self.timeLabelView) {
        self.timeLabelView.frame = CGRectMake(0, 32, 320, 20);
        self.timeLabelView.hidden = YES;
    }
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[NWActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicatorView.frame = CGRectMake(105, 15, 20, 20);
        _activityIndicatorView.color = NWColorRGB(70, 154, 233);
        _activityIndicatorView.hidden = YES;
        [self addSubview:_activityIndicatorView];
    }
}

-(void)changeState:(ePullStateType)state
{
    switch (state) {
        case ePullStateTypeNormal:
            self.state = ePullStateTypeNormal;
            self.stateLabel.text = @"上拉即可加载";
            [_activityIndicatorView stopAnimating];
            _activityIndicatorView.hidden = YES;
            break;
            
        case ePullStateTypeUp:
            self.state = ePullStateTypeUp;
            [_activityIndicatorView stopAnimating];
            _activityIndicatorView.hidden = YES;
            self.stateLabel.text = @"松开加载更多";
            break;
            
        case ePullStateTypeLoadMore:
            self.state = ePullStateTypeLoadMore;
            [_activityIndicatorView startAnimating];
            _activityIndicatorView.hidden = NO;
            self.stateLabel.text = @"加载中...";
            break;
            
        case ePullStateTypeEnd:
            self.state = ePullStateTypeEnd;
            [_activityIndicatorView stopAnimating];
            _activityIndicatorView.hidden = YES;
            self.timeLabelView.hidden = YES;
            self.stateLabel.text = @"没有更多结果了 :)";
            break;
            
        default:
            break;
    }
    
}

@end
