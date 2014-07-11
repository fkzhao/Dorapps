//
//  NWNavigationBar.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWNavigationBar.h"
#import "NWUIDefine.h"

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


@end
