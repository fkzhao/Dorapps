//
//  NWCircularProgressButton.h
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NWCircularProgressButtonDelegate <NSObject>

@optional

- (void)updateProgressViewWithProgress:(float)progress;

@end

@interface NWCircularProgressButton : UIButton
@property (nonatomic) float progress;
@property (nonatomic) UIColor *backColor;
@property (nonatomic) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) id <NWCircularProgressButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth;

- (void)setProgress:(float)progress;

@end
