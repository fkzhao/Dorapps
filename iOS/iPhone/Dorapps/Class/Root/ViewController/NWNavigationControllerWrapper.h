//
//  NWNavigationControllerWrapper.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NWNavigationController;

@interface NWNavigationControllerWrapper : NSObject

+ (NWNavigationController *) navigationControllerWithRootViewController:(UIViewController *)rootViewController;

@end
