//
//  NWNavigationControllerWrapper.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWNavigationControllerWrapper.h"
#import "NWNavigationController.h"
#import "NWRootViewController.h"

@implementation NWNavigationControllerWrapper
+ (UINavigationController *) navigationControllerWithRootViewController:(UIViewController *)rootViewController
{
    NWNavigationController *navigationController = nil;
    UINib *nib = [UINib nibWithNibName:@"CTNavigationController" bundle:nil];
    navigationController = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    navigationController.viewControllers = [NSArray arrayWithObjects:rootViewController, nil];
//    if ([rootViewController isKindOfClass:[NWRootViewController class]])
//    {
//        ((NWRootViewController *)rootViewController).navigationController = navigationController;
//    }
    return navigationController;
}

@end
