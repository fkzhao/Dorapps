//
//  NWAppDelegate.h
//  APPVV
//
//  Created by Anselz on 14-6-15.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NWNavigationController;
@class NWTabBarViewController;

@interface NWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NWNavigationController *rootViewController;
@property (strong, nonatomic) NWTabBarViewController *mainViewController;
@end
