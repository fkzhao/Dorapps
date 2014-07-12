//
//  NWHeaderStateView.h
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWStateView.h"
#import "NWRefreshCircleView.h"

#define kFBRefreshCircleViewHeight 20

@interface NWHeaderStateView : NWStateView
@property (nonatomic, strong) NWRefreshCircleView *refreshCircleView;
-(void)setOffSetY:(CGFloat)offsetY;

@end
