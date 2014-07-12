//
//  NWTableView.m
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWTableView.h"
#import "NWRefreshControl.h"
@interface NWTableView ()
{
    NWRefreshControl *refreshControl_;
}

@property (nonatomic,strong) NWRefreshControl *refreshControl;

@end

@implementation NWTableView
@synthesize refreshControl = refreshControl_;

#pragma mark - --------------------退出清空--------------------

#pragma mark - --------------------初始化--------------------

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initBaseView];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseView];
}


-(void)initBaseData
{
    
}

-(void)initBaseView
{
    if (nil == refreshControl_) {
        refreshControl_ = [[NWRefreshControl alloc] initWithScrollView:self];
    }
}

-(void)setTableViewStateRefreshing
{
    if (refreshControl_) {
        refreshControl_.footerView.stateLabel.text = @"";
        [refreshControl_ setTableViewStatus:ePullStateTypeRefresh];
    }
}
- (void)reloadDataWithIsAllLoaded:(BOOL)isAllLoaded{
    [super reloadData];
    [UIView animateWithDuration:0.5 animations:^(void){
        [self setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    } completion:^(BOOL finished) {
        [refreshControl_.headerView changeState:ePullStateTypeNormal];
        [refreshControl_.headerView updateTimeLabel];
        
        if (isAllLoaded) {
            [refreshControl_.footerView changeState:ePullStateTypeEnd];
        } else {
            [refreshControl_.footerView changeState:ePullStateTypeNormal];
        }
    }] ;
}


@end
