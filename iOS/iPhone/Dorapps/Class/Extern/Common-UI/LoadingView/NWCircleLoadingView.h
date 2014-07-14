//
//  NWCircleLoadingView.h
//  Dorapps
//
//  Created by Anselz on 14-7-14.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ANGLE(a) 2*M_PI/360*a

@interface NWCircleLoadingView : UIView

//default is 1.0f
@property (nonatomic, assign) CGFloat lineWidth;

//default is [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, readonly) BOOL isAnimating;

//use this to init
- (id)initWithFrame:(CGRect)frame;

- (void)startAnimation;
- (void)stopAnimation;

@end
