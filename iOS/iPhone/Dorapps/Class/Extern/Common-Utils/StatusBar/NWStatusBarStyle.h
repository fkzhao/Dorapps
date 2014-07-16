//
//  NWStatusBarStyle.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const NWStatusBarStyleError;   /// This style has a red background with a white Helvetica label.
extern NSString *const NWStatusBarStyleWarning; /// This style has a yellow background with a gray Helvetica label.
extern NSString *const NWStatusBarStyleSuccess; /// This style has a green background with a white Helvetica label.
extern NSString *const NWStatusBarStyleMatrix;  /// This style has a black background with a green bold Courier label.
extern NSString *const NWStatusBarStyleDefault; /// This style has a white background with a gray Helvetica label.
extern NSString *const NWStatusBarStyleDark;    /// This style has a nearly black background with a nearly white Helvetica label.

typedef NS_ENUM(NSInteger, NWStatusBarAnimationType) {
    NWStatusBarAnimationTypeNone,   /// Notification won't animate
    NWStatusBarAnimationTypeMove,   /// Notification will move in from the top, and move out again to the top
    NWStatusBarAnimationTypeBounce, /// Notification will fall down from the top and bounce a little bit
    NWStatusBarAnimationTypeFade    /// Notification will fade in and fade out
};

typedef NS_ENUM(NSInteger, NWStatusBarProgressBarPosition) {
    NWStatusBarProgressBarPositionBottom, /// progress bar will be at the bottom of the status bar
    NWStatusBarProgressBarPositionCenter, /// progress bar will be at the center of the status bar
    NWStatusBarProgressBarPositionTop,    /// progress bar will be at the top of the status bar
    NWStatusBarProgressBarPositionBelow,  /// progress bar will be below the status bar (the prograss bar won't move with the statusbar in this case)
    NWStatusBarProgressBarPositionNavBar, /// progress bar will be below the navigation bar (the prograss bar won't move with the statusbar in this case)
};

@interface NWStatusBarStyle : NSObject

/// The background color of the notification bar
@property (nonatomic, strong) UIColor *barColor;

/// The text color of the notification label
@property (nonatomic, strong) UIColor *textColor;

/// The text shadow of the notification label
@property (nonatomic, strong) NSShadow *textShadow;

/// The font of the notification label
@property (nonatomic, strong) UIFont *font;

/// A correction of the vertical label position in points. Default is 0.0
@property (nonatomic, assign) CGFloat textVerticalPositionAdjustment;

#pragma mark Animation

/// The animation, that is used to present the notification
@property (nonatomic, assign) NWStatusBarAnimationType animationType;

#pragma mark Progress Bar

/// The background color of the progress bar (on top of the notification bar)
@property (nonatomic, strong) UIColor *progressBarColor;

/// The height of the progress bar. Default is 1.0
@property (nonatomic, assign) CGFloat progressBarHeight;

/// The position of the progress bar. Default is NWStatusBarProgressBarPositionBottom
@property (nonatomic, assign) NWStatusBarProgressBarPosition progressBarPosition;

@end
