//
//  NWTabBarViewController.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWRootViewController.h"
@class NWTabBarViewController;
@protocol NWTabBarViewControllerDelegate <NSObject>

-(void)selectViewController:(NWTabBarViewController *)tabbarViewController atIndex:(NSInteger)index;

@end
@interface NWTabBarViewController : NWRootViewController

@property (nonatomic,strong) NSMutableArray *controllers;

- (id)initWithControlles:(NSArray *)viewControllers;
-(void)setViewControllers:(NSArray *)viewControllers;

@end
