//
//  UIViewController+NWNavigationBar.h
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWNavigationBar.h"
#import "NSString+FontAwesome.h"

@interface UIViewController (NWNavigationBar)

/**
 增加返回按钮
 @param target 消息绑定目标
 @param selector 消息绑定方法
 */
- (void)setBackButtonWithTarget:(id)target action:(SEL)selector;
@end
