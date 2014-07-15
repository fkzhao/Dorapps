//
//  NWAppDelegate.h
//  Dorapps
//
//  Created by Anselz on 14-7-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NWNavigationController;
@class NWTabBarViewController;

@interface NWAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NWNavigationController *rootViewController;
@property (strong, nonatomic) UITabBarController *mainViewController;

@end
