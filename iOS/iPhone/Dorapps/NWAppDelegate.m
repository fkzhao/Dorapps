//
//  NWAppDelegate.m
//  Dorapps
//
//  Created by Anselz on 14-7-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWAppDelegate.h"
#import "NWHotViewController.h"
#import "NWManageViewController.h"
#import "NWSearchViewController.h"
#import "NWMoreViewController.h"
#import "NWTabBarViewController.h"
#import "NWCoreDataUtil.h"
#import "NWUpdateManager.h"
#import "NWUIConfig.h"
#import "NWCategoryViewController.h"

@implementation NWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self loadViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)loadViewController
{
    NWHotViewController *hot = [[NWHotViewController alloc]init];
    hot.title = @"Hot";
    hot.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"Hot" image:[self imageWithImage:[UIImage imageNamed:@"home"] scaledToSize:CGSizeMake(25, 25)] tag:1];
    NWManageViewController *manage = [[NWManageViewController alloc]init];
    manage.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"Manager" image:[self imageWithImage:[UIImage imageNamed:@"manager"] scaledToSize:CGSizeMake(25, 25)] tag:1];
    NWSearchViewController *search = [[NWSearchViewController alloc]init];
    search.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    NWMoreViewController *more = [[NWMoreViewController alloc]init];
    more.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
    
    UITabBarController *rootVC = [[UITabBarController alloc] init];
    rootVC.delegate = self;
    rootVC.edgesForExtendedLayout = UIRectEdgeNone;
    rootVC.tabBar.tintColor = [UIColor colorWithRed:70.0/255.0 green:154.0/255.0 blue:233.0/255.0 alpha:1.0];
    rootVC.viewControllers = @[hot,search,manage,more];
    self.mainViewController = rootVC;
    
    [self tabBarController:rootVC didSelectViewController:hot];

    NWNavigationController *rootNav = [[NWNavigationController alloc]initWithRootViewController:rootVC];
    self.rootViewController = rootNav;
    self.window.rootViewController = self.rootViewController;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[NWHotViewController class]]) {
        UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [menuButton setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(showAppCategory) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
        tabBarController.navigationItem.rightBarButtonItem = rightBarButtonItem;
    } else {
        tabBarController.navigationItem.rightBarButtonItem = nil;
    }
    tabBarController.title = viewController.title;
}


-(void)showAppCategory
{
    NWCategoryViewController *viewController = [[NWCategoryViewController alloc]init];
    viewController.delegate = (id)self;
    NWNavigationController *navController = [[NWNavigationController alloc]initWithRootViewController:viewController];
    viewController.edgesForExtendedLayout = UIRectEdgeNone;
    [self.mainViewController presentViewController:navController animated:YES completion:^{
        
    }];
}

-(void)selectMenuAtIndex:(NSInteger)selectIndex
{
    NWHotViewController *hot = (NWHotViewController *)self.mainViewController.selectedViewController ;
    [hot selectCategoryAction:selectIndex];
}

-(void)checkAppUpdate
{
    NWUpdateManager *mgr = [NWUpdateManager sharedManager];
    [mgr checkForUpdates:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [NWCoreDataUtil saveContext];
}

@end
