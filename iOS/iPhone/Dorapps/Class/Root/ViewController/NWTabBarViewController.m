//
//  NWTabBarViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWTabBarViewController.h"
#import "NWToolBarView.h"

@interface NWTabBarViewController ()<NWToolBarViewDelegate> {
    NWRootViewController *currentViewController;
}

@property (weak, nonatomic) IBOutlet NWToolBarView *toolBar;
@property (weak, nonatomic) IBOutlet UIView *childView;
@end

@implementation NWTabBarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initBaseData];
    }
    return self;
}
- (id)initWithControlles:(NSArray *)viewControllers {
    self = [super init];
    if (self) {
        [self setViewControllers:viewControllers];
    }
    return self;
}
-(void)initBaseData {
    if (!_controllers) {
        _controllers = [[NSMutableArray alloc]initWithCapacity:0];
    }
    currentViewController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toolBar.delegate = self;
    
    for (NWRootViewController *vc in self.controllers) {
        vc.view.frame = self.childView.bounds;
//        [self addChildViewController:vc];
    }
    if (self.controllers.count > 0) {
        currentViewController= (NWRootViewController *)[self.controllers objectAtIndex:0];
        self.title = currentViewController.title;
        [self.childView addSubview:currentViewController.view];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
-(void)initBaseView {
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setViewControllers:(NSArray *)viewControllers {
    for (id vc in viewControllers) {
        [self.controllers addObject:vc];
    }
}

-(void)selectItemAtIndex:(NSInteger)index {
    NSInteger selectIndex = index - 1;
    NWRootViewController *currentVC = nil;
    if (self.controllers.count > selectIndex) {
        currentVC = (NWRootViewController *)[self.controllers objectAtIndex:selectIndex];
        [currentViewController.view removeFromSuperview];
        currentViewController = currentVC;
        currentViewController.view.frame = self.childView.bounds;
        [self.childView addSubview:currentViewController.view];
//        [self transitionFromViewController:currentViewController toViewController:currentVC duration:1.0 options:0 animations:^{
//        }  completion:^(BOOL finished) {
//            currentViewController = currentVC;
//        }];
        self.title = currentVC.title;
    }
    
}
@end
