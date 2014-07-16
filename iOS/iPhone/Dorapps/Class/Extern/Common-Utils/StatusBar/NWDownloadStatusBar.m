//
//  NWDownloadStatusBar.m
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadStatusBar.h"
#import "NWStatusBarNotification.h"
#import "NWUIDefine.h"

@implementation NWDownloadStatusBar

+(void)showStatusBar:(NSString *)title
{
    NWDownloadStatusBar *statusBar = [[NWDownloadStatusBar alloc]init];
    [statusBar updateStyle];
    [statusBar start:title];
}

-(void)start:(NSString *)title
{
    double delayInSeconds = [NWStatusBarNotification isVisible] ? 0.0 : 0.25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.progress = 0.0;
        [self startTimer];
    });
    
    [NWStatusBarNotification showWithStatus:title dismissAfter:1.3 styleName:@"style"];
}

- (void)updateStyle;
{
    [NWStatusBarNotification addStyleNamed:@"style" prepare:^NWStatusBarStyle *(NWStatusBarStyle *style) {
        style.font = [UIFont systemFontOfSize:13];
        style.textColor = [UIColor whiteColor];
        style.barColor = NWColorRGB(105, 175, 240);;
        style.animationType = NWStatusBarAnimationTypeMove;
        style.progressBarColor = [UIColor lightGrayColor];
        style.progressBarPosition = NWStatusBarProgressBarPositionBottom;
        return style;
    }];
}

#pragma mark Progress Timer

- (void)startTimer;
{
    [NWStatusBarNotification showProgress:self.progress];
    
    [self.timer invalidate];
    self.timer = nil;
    
    if (self.progress < 1.0) {
        CGFloat step = 0.02;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:step target:self
                                                    selector:@selector(startTimer)
                                                    userInfo:nil repeats:NO];
        self.progress += step;
    } else {
        [self performSelector:@selector(hideProgress)
                   withObject:nil afterDelay:0.5];
    }
}

- (void)hideProgress;
{
    [NWStatusBarNotification showProgress:0.0];
}

@end
