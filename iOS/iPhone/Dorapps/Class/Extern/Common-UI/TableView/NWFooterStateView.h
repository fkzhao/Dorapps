//
//  NWFooterStateView.h
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWUIDefine.h"

#define kXHLoadMoreViewHeight 50

@interface NWFooterStateView : UIView

@property (nonatomic, strong) UIButton *loadMoreButton;

- (void)startLoading;

- (void)endLoading;

- (void)configuraManualState;

- (void)configuraNothingMoreWithMessage:(NSString *)message;


@end
