//
//  NWNavigationBar.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWNavigationBar.h"
#import "NWUIDefine.h"
#import "NWUIConfig.h"

@implementation NWNavigationBar

#pragma mark - System
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseView];
}

- (void)initBaseView
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self setBarTintColor:NWColorRGB(70, 154, 233)];
    }
    self.tintColor = [UIColor whiteColor];
}


#pragma mark - --------------------System--------------------

- (void)customDrawRect:(CGRect)rect
{
    UIColor *color = NWColorRGB(70, 154, 233);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, rect);
}

- (void)setBarTintColor:(UIColor *)barTintColor
{
    [super setBarTintColor:barTintColor];
    
}

+ (UIBarButtonItem *)createBarButtonItemWithCustomView:(UIView *)view
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    return item;
}

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    if (!title) {
        return nil;
    }
    CGFloat barItemMargin;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        barItemMargin = 11.0f;
    }
    else
    {
        barItemMargin = 0.0f;
    }
    CGFloat width = 0.0f;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        width = [title sizeWithFont:kNavigationBarButtonFont].width + barItemMargin;
    } else {
        width = [title sizeWithAttributes:@{NSFontAttributeName :kNavigationBarButtonFont}].width;
    }
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton.titleLabel setFont:kNavigationBarButtonFont];
    [customButton setTitleColor:kNavigationBarButtonNormalColor forState:UIControlStateNormal];
    [customButton setTitleColor:kNavigationBarButtonHighlightColor forState:UIControlStateHighlighted];
    [customButton setTitleColor:kNavigationBarButtonDisableColor forState:UIControlStateDisabled];
    [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 1)];
    
    [customButton setFrame:CGRectMake(0, 0, width+5, 44)];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [NWNavigationBar createBarButtonItemWithCustomView:customButton];
}

@end
