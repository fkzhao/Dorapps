//
//  NWHeaderStateView.h
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWRefreshCircleView.h"

@interface NWHeaderStateView : UIView
@property (nonatomic, strong) NWRefreshCircleView *refreshCircleView;
@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UILabel *timeLabel;
@end
