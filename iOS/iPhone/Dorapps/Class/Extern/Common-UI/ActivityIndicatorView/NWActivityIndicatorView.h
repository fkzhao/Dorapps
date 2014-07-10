//
//  NWActivityIndicatorView.h
//  APPVV
//
//  Created by Anselz on 14-6-17.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum NWActivityIndicatorDirection
{
    NWActivityIndicatorDirectionClockwise = -1,
    NWActivityIndicatorDirectionCounterClockwise = 1
} NWActivityIndicatorDirection;


@interface NWActivityIndicatorView : UIView
{
    NSUInteger      _steps;
    CGFloat         _stepDuration;
    BOOL            _isAnimating;
    
    UIColor                         *_color;
    BOOL                            _hidesWhenStopped;
    UIRectCorner                    _roundedCoreners;
    CGSize                          _cornerRadii;
    CGSize                          _finSize;
    NWActivityIndicatorDirection    _direction;
    UIActivityIndicatorViewStyle    _actualActivityIndicatorViewStyle;
}

@property (nonatomic) NSUInteger                    steps;
@property (nonatomic) NSUInteger                    indicatorRadius;
@property (nonatomic) CGFloat                       stepDuration;
@property (nonatomic) CGSize                        finSize;
@property (nonatomic, strong) UIColor               *color;
@property (nonatomic) UIRectCorner                  roundedCoreners;
@property (nonatomic) CGSize                        cornerRadii;
@property (nonatomic) NWActivityIndicatorDirection  direction;
@property (nonatomic) UIActivityIndicatorViewStyle  activityIndicatorViewStyle;

@property(nonatomic) BOOL                           hidesWhenStopped;

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

- (CGPathRef)finPathWithRect:(CGRect)rect;

@end
