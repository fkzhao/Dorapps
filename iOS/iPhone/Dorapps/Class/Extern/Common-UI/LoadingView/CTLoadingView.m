//
//  CTLoadingView.m
//  STAYREAL
//
//  Created by Anselz on 13-8-6.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTLoadingView.h"
#import "RTSpinKitView.h"
#import "NWDefine.h"
#import "NWConfig.h"

/**
 判断是否是iPhone5 的屏幕
 */
BOOL isIphone5()
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (size.height == 568) {
        return YES;
    } else {
        return NO;
    }
}




@implementation CTLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.toke = @"";
    }
    return self;
}

+(void)showInView:(UIView *)view withToken:(NSString *)token{
    CGRect frame = view.bounds;
    frame.origin.y = -2;
    if (isIphone5()) {
        if (isIos7) {
            frame.size.height = 568-64;
        } else {
            frame.size.height = 568-60;
        }
    } else {
        if (isIos7) {
            frame.size.height = 480-64;
        } else {
            frame.size.height = 480-60;
        }
    }
    
    CTLoadingView *loadingView = [[CTLoadingView alloc]initWithFrame:frame];
    loadingView.toke = token;
    loadingView.backgroundColor = NWColorRGB(246, 246, 249);
    loadingView.alpha = 1.0;
    [loadingView insertSpinner:[[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWave color:NWColorRGB(70, 154, 233)]
               backgroundColor:NWColorRGB(246, 246, 249)];
    [view addSubview:loadingView];
}

-(void)insertSpinner:(RTSpinKitView*)spinner
     backgroundColor:(UIColor*)backgroundColor
{
    UIView *panel = [[UIView alloc] initWithFrame:self.bounds];
    panel.backgroundColor = backgroundColor;
    
    spinner.center = self.center;
    [panel addSubview:spinner];
    
    [self addSubview:panel];
}

+(void)removeFromView:(UIView *)view withToken:(NSString *)token{
    for (id subView in [view subviews]) {
        if ([subView isKindOfClass:[CTLoadingView class]]) {
            CTLoadingView *loadingView = (CTLoadingView *)subView;
            if ([loadingView.toke isEqualToString:token]) {
                [loadingView removeFromSuperview];
            }
        }
    }
}
@end
