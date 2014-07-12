//
//  UIViewController+NWNavigationBar.m
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "UIViewController+NWNavigationBar.h"

@implementation UIViewController (NWNavigationBar)

- (void)setBackBarButtonItem:(UIBarButtonItem *)item
{
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setBackButtonWithTarget:(id)target action:(SEL)selector
{
    CGFloat barItemMargin;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        barItemMargin = 0.0f;
    }
    else
    {
        barItemMargin = 22.0f;
    }
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* image = [UIImage imageNamed:@"btn_back_arrow.png"];
    UIImage* pressedImage = [UIImage imageNamed:@"btn_back_arrow_focus.png"];
    [customButton setImage:image forState:UIControlStateNormal];
    [customButton setImage:pressedImage forState:UIControlStateHighlighted];
    
//    customButton.titleLabel.font = [UIFont fontWithName:kFontAwesomeFamilyName size:36];
//    customButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [customButton setTitle:[NSString fontAwesomeIconStringForEnum:FAKIconAngleLeft] forState:UIControlStateNormal];
//    [customButton setTitle:[NSString fontAwesomeIconStringForEnum:FAKIconAngleLeft] forState:UIControlStateHighlighted];
//    [customButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        
    [customButton setFrame:CGRectMake(0, 0, 22+barItemMargin, 44)];
    [customButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self setBackBarButtonItem:[NWNavigationBar createBarButtonItemWithCustomView:customButton]];
}

@end
