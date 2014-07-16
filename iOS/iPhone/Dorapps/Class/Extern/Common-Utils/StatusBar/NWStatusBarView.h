//
//  NWStatusBarView.h
//  Dorapps
//
//  Created by Anselz on 14-7-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWStatusBarView : UIView

@property (nonatomic, strong, readonly) UILabel *textLabel;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, assign) CGFloat textVerticalPositionAdjustment;

@end
