//
//  NWTabBarViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWTabBarViewController.h"
#import "NWToolBarView.h"
#import "NWMenuListView.h"
#import "NWHotViewController.h"

@interface NWTabBarViewController ()<NWToolBarViewDelegate,NWMenuListDelegate> {
    NWRootViewController *currentViewController;
    BOOL _isShowing;
    NWMenuListView *_menuList;
}

@property (weak, nonatomic) IBOutlet NWToolBarView *toolBar;
@property (weak, nonatomic) IBOutlet UIView *childView;
@property (nonatomic,strong) UIBarButtonItem *rightBarButtonItem;
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
    _isShowing = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toolBar.delegate = self;
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [menuButton setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(showAppCategory) forControlEvents:UIControlEventTouchUpInside];
    self.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuButton];
    [self currentNavigationItem].rightBarButtonItem = self.rightBarButtonItem;
    
    
    for (NWRootViewController *vc in self.controllers) {
        vc.view.frame = self.childView.bounds;
    }
    if (self.controllers.count > 0) {
        currentViewController= (NWRootViewController *)[self.controllers objectAtIndex:0];
        self.title = currentViewController.title;
        [self.childView addSubview:currentViewController.view];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)showAppCategory
{
    if (!_menuList) {
        _menuList = [[NWMenuListView alloc]initWithFrame:CGRectMake(0, -568, 320, 504)];
        _menuList.menuDelegate = self;
        [self.view addSubview:_menuList];
    }
    if (_isShowing) {
        [UIView animateWithDuration:0.5 animations:^{
            _menuList.mainTableView.frame = CGRectMake(_menuList.bounds.origin.x, -_menuList.bounds.size.height, _menuList.bounds.size.width, _menuList.bounds.size.height);
            _menuList.frame = CGRectMake(_menuList.bounds.origin.x, -_menuList.bounds.size.height-64, _menuList.bounds.size.width, _menuList.bounds.size.height);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _menuList.frame = CGRectMake(0, 64, _menuList.bounds.size.width, _menuList.bounds.size.height);
            _menuList.mainTableView.frame = CGRectMake(0, _menuList.bounds.origin.y + 20, _menuList.bounds.size.height, _menuList.bounds.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                _menuList.mainTableView.frame = CGRectMake(0, _menuList.bounds.origin.y, _menuList.bounds.size.height, _menuList.bounds.size.height);
            }];
        }];
    }
    _isShowing = !_isShowing;
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
        if ([currentViewController isKindOfClass:[NWHotViewController class]]) {
            [self currentNavigationItem].rightBarButtonItem = self.rightBarButtonItem;
        } else {
            [self currentNavigationItem].rightBarButtonItem = nil;
        }
        currentViewController.view.frame = self.childView.bounds;
        [self.childView addSubview:currentViewController.view];
        self.title = currentVC.title;
    }
}

-(void)selectMenuAtIndex:(NSInteger)selectIndex
{
    [self showAppCategory];
    if ([currentViewController isKindOfClass:[NWHotViewController class]]) {
        NWHotViewController *vc = (NWHotViewController *)currentViewController;
        [vc selectCategoryAction:selectIndex];
    }
}
@end
