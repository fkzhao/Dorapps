//
//  NWHeaderStateView.m
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHeaderStateView.h"

@implementation NWHeaderStateView


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
    self.stateLabel.text = @"下拉刷新";
    self.stateLabel.textColor = [UIColor blackColor];
    [self.stateLabel setFrame:CGRectMake(140, 32, 180, 20)];
    [self addSubview:self.refreshCircleView];
}

-(void)changeState:(ePullStateType)state
{
    switch (state) {
        case ePullStateTypeNormal:
        {
            self.state = ePullStateTypeNormal;
            [self.refreshCircleView stopAnimation];
            self.stateLabel.text = @"下拉可以刷新";
        }
            break;
        case ePullStateTypeDown:
        {
            self.state = ePullStateTypeDown;
            self.stateLabel.text = @"松开可以刷新";
        }
            break;
            
        case ePullStateTypeRefresh:
        {
            self.state = ePullStateTypeRefresh;
            [self.refreshCircleView startAnimation];
            self.stateLabel.text = @" 刷新中";
        }
            break;
        default:
            break;
    }
}

- (NWRefreshCircleView *)refreshCircleView {
    if (!_refreshCircleView) {
        _refreshCircleView = [[NWRefreshCircleView alloc] initWithFrame:CGRectMake(110,32, kFBRefreshCircleViewHeight, kFBRefreshCircleViewHeight)];
    }
    return _refreshCircleView;
}

-(void)setOffSetY:(CGFloat)offsetY
{
    CGFloat minY = MIN(ABS(offsetY), kFBDefaultRefreshTotalPixels);
    CGFloat offSetY =  minY - kFBRefreshCircleViewHeight;
    [self.refreshCircleView setOffSetY:offSetY];
}

@end
