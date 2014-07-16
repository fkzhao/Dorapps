//
//  NWStatusBarStyle.m
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWStatusBarStyle.h"

NSString *const NWStatusBarStyleError   = @"NWStatusBarStyleError";
NSString *const NWStatusBarStyleWarning = @"NWStatusBarStyleWarning";
NSString *const NWStatusBarStyleSuccess = @"NWStatusBarStyleSuccess";
NSString *const NWStatusBarStyleMatrix  = @"NWStatusBarStyleMatrix";
NSString *const NWStatusBarStyleDefault = @"NWStatusBarStyleDefault";
NSString *const NWStatusBarStyleDark    = @"NWStatusBarStyleDark";

@implementation NWStatusBarStyle

- (instancetype)copyWithZone:(NSZone*)zone;
{
    NWStatusBarStyle *style = [[[self class] allocWithZone:zone] init];
    style.barColor = self.barColor;
    style.textColor = self.textColor;
    style.textShadow = self.textShadow;
    style.font = self.font;
    style.textVerticalPositionAdjustment = self.textVerticalPositionAdjustment;
    style.animationType = self.animationType;
    style.progressBarColor = self.progressBarColor;
    style.progressBarHeight = self.progressBarHeight;
    style.progressBarPosition = self.progressBarPosition;
    return style;
}

+ (NSArray*)allDefaultStyleIdentifier;
{
    return @[NWStatusBarStyleError, NWStatusBarStyleWarning,
             NWStatusBarStyleSuccess, NWStatusBarStyleMatrix,
             NWStatusBarStyleDark];
}

+ (NWStatusBarStyle*)defaultStyleWithName:(NSString*)styleName;
{
    // setup default style
    NWStatusBarStyle *style = [[NWStatusBarStyle alloc] init];
    style.barColor = [UIColor whiteColor];
    style.progressBarColor = [UIColor greenColor];
    style.progressBarHeight = 1.0;
    style.progressBarPosition = NWStatusBarProgressBarPositionBottom;
    style.textColor = [UIColor grayColor];
    style.font = [UIFont systemFontOfSize:12.0];
    style.animationType = NWStatusBarAnimationTypeMove;
    
    // NWStatusBarStyleDefault
    if ([styleName isEqualToString:NWStatusBarStyleDefault]) {
        return style;
    }
    
    // NWStatusBarStyleError
    else if ([styleName isEqualToString:NWStatusBarStyleError]) {
        style.barColor = [UIColor colorWithRed:0.588 green:0.118 blue:0.000 alpha:1.000];
        style.textColor = [UIColor whiteColor];
        style.progressBarColor = [UIColor redColor];
        style.progressBarHeight = 2.0;
        return style;
    }
    
    // NWStatusBarStyleWarning
    else if ([styleName isEqualToString:NWStatusBarStyleWarning]) {
        style.barColor = [UIColor colorWithRed:0.900 green:0.734 blue:0.034 alpha:1.000];
        style.textColor = [UIColor darkGrayColor];
        style.progressBarColor = style.textColor;
        return style;
    }
    
    // NWStatusBarStyleSuccess
    else if ([styleName isEqualToString:NWStatusBarStyleSuccess]) {
        style.barColor = [UIColor colorWithRed:0.588 green:0.797 blue:0.000 alpha:1.000];
        style.textColor = [UIColor whiteColor];
        style.progressBarColor = [UIColor colorWithRed:0.106 green:0.594 blue:0.319 alpha:1.000];
        style.progressBarHeight = 1.0+1.0/[[UIScreen mainScreen] scale];
        return style;
    }
    
    // NWStatusBarStyleDark
    else if ([styleName isEqualToString:NWStatusBarStyleDark]) {
        style.barColor = [UIColor colorWithRed:0.050 green:0.078 blue:0.120 alpha:1.000];
        style.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        style.progressBarHeight = 1.0+1.0/[[UIScreen mainScreen] scale];
        return style;
    }
    
    // NWStatusBarStyleMatrix
    else if ([styleName isEqualToString:NWStatusBarStyleMatrix]) {
        style.barColor = [UIColor blackColor];
        style.textColor = [UIColor greenColor];
        style.font = [UIFont fontWithName:@"Courier-Bold" size:14.0];
        style.progressBarColor = [UIColor greenColor];
        style.progressBarHeight = 2.0;
        return style;
    }
    
    return nil;
}

@end
