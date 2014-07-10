//
//  NWNavigationController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWNavigationController.h"

@interface NWNavigationController ()

@end

@implementation NWNavigationController

#pragma mark - --------------------初始化--------------------

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    NWNavigationController *navVC = [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
    [navVC setViewControllers:[NSArray arrayWithObject:rootViewController]];
    return navVC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [[[NSBundle mainBundle] loadNibNamed:(nibNameOrNil.length > 0) ? nibNameOrNil : NSStringFromClass([self class]) owner:nil options:nil] objectAtIndex:0];
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
