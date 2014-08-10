//
//  NWCircularProgressButton.m
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWCircularProgressButton.h"

@interface NWCircularProgressButton ()

@property (assign, nonatomic) CGFloat angle;

@end

@implementation NWCircularProgressButton

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *imgPause = [UIImage imageNamed:@"file_pause_normal.png"];
        UIImage *imgDown =[UIImage imageNamed:@"file_download_normal.png"];
        [self setBackgroundImage:imgPause forState:UIControlStateNormal];
        [self setBackgroundImage:imgDown  forState:UIControlStateSelected];
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        _backColor = backColor;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBaseData];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseView];
}

-(void)initBaseData
{
    _progressColor = [UIColor redColor];
    _lineWidth = 2;
    _backColor = [UIColor lightGrayColor];
}

-(void)initBaseView
{
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateHighlighted];
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateProgressViewWithProgress:)]) {
        [self.delegate updateProgressViewWithProgress:self.progress];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2)
                                                              radius:(CGRectGetWidth(self.bounds) - self.lineWidth ) / 2
                                                          startAngle:(CGFloat) - M_PI_2
                                                            endAngle:(CGFloat)(1.5 * M_PI)
                                                           clockwise:YES];
    [self.backColor setStroke];
    backCircle.lineWidth = self.lineWidth;
    [backCircle stroke];
    
    if (self.progress) {
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2)
                                                                      radius:(CGRectGetWidth(self.bounds) - self.lineWidth ) / 2
                                                                  startAngle:(CGFloat) - M_PI_2
                                                                    endAngle:(CGFloat)(- M_PI_2 + self.progress * 2 * M_PI)
                                                                   clockwise:YES];
        [self.progressColor setStroke];
        progressCircle.lineWidth = self.lineWidth;
        [progressCircle stroke];
    }
}

@end
