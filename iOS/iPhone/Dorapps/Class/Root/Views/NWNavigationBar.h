//
//  NWNavigationBar.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWNavigationBar.h"

@interface NWNavigationBar : UINavigationBar

- (void)customDrawRect:(CGRect)rect;

/**
 通过标题生成UIBarButtonItem
 
 @param title 标题
 @param target 事件目标对象
 @param action 事件响应方法
 */
+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 通过自定义视图生成UIBarButtonItem
 
 @param view 自定义视图
 */
+ (UIBarButtonItem *)createBarButtonItemWithCustomView:(UIView *)view;

@end
