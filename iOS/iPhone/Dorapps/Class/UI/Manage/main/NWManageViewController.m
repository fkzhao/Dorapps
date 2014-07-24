//
//  NWManageViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWManageViewController.h"
#import "NWDownloadedView.h"
#import "NWDownloadingView.h"
#import "NWInstalledView.h"
#import "NWUpdateView.h"
#import "NWSegmentedControl.h"
#import "NWUpdateAppSender.h"
#import "NWUpdateViewCacheBean.h"

@interface NWManageViewController ()
{
    UIView *_currentView;
}
@property (nonatomic,strong) NWDownloadedView *downloadedView;
@property (nonatomic,strong) NWDownloadingView *downloadingView;
@property (nonatomic,strong) NWInstalledView *installedView;
@property (nonatomic,strong) NWUpdateView *updateView;
@property (strong, nonatomic)  NWSegmentedControl *segmentControl;

@end

@implementation NWManageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initView
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handlerSwipeView:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    swipe = nil;
    swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handlerSwipeView:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipe];
    
    self.title = [NWStringUtil getLocalizationString:LocationFlag_Title_MANAGER];
    if (!_segmentControl) {
        // Segmented control with scrolling
        NSArray *titles = [NSArray arrayWithObjects:[NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Downloading], [NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Downloaded], [NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Installed], [NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Update], nil];
        
        _segmentControl = [[NWSegmentedControl alloc] initWithSectionTitles:titles];
        _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _segmentControl.frame = CGRectMake(0, 0, 320, 40);
        _segmentControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _segmentControl.selectionStyle = NWSegmentedControlSelectionStyleFullWidthStripe;
        _segmentControl.selectionIndicatorLocation = NWSegmentedControlSelectionIndicatorLocationDown;
        [_segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_segmentControl];

    }
    if (!_downloadedView) {
        _downloadedView = [[NWDownloadedView alloc]initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height - 40)];
    }
    if (!_downloadingView) {
         _downloadingView = [[NWDownloadingView alloc]initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height - 40)];
    }
    if (!_installedView) {
        _installedView = [[NWInstalledView alloc]initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height - 40)];
    }
    if (!_updateView) {
        _updateView = [[NWUpdateView alloc]initWithFrame:CGRectMake(0, 40, 320, self.view.frame.size.height - 40)];
        __weak NWManageViewController *_weakSelf = self;
        _updateView.updateBlock = ^(){
            [_weakSelf pullUpadteViewTableView];
        };
    }
    _currentView = _downloadingView;
    [self.view addSubview:_currentView];
}

-(void)handlerSwipeView:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_segmentControl.selectedSegmentIndex > 0) {
            _segmentControl.selectedSegmentIndex = _segmentControl.selectedSegmentIndex - 1;
            [self segmentedControlChangedValue:_segmentControl];
        }
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        if (_segmentControl.selectedSegmentIndex < 3) {
             _segmentControl.selectedSegmentIndex = _segmentControl.selectedSegmentIndex + 1;
            [self segmentedControlChangedValue:_segmentControl];
        }
    }
}

- (void)segmentedControlChangedValue:(NWSegmentedControl *)segmentedControl {
	NWSegmentedControl *seg = segmentedControl;
    UIView *tmpView = nil;
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            [self currentNavigationItem].rightBarButtonItem = nil;
            tmpView = _downloadingView;
        }
            break;
        case 1:
        {
            [self currentNavigationItem].rightBarButtonItem = nil;
            tmpView = _downloadedView;
        }
            break;
        case 2:
        {
            [self currentNavigationItem].rightBarButtonItem = nil;
            tmpView = _installedView;
        }
            break;
        case 3:
        {
//            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新全部" style:UIBarButtonItemStylePlain target:self action:@selector(updateAllApps)];
            [self pullUpadteViewTableView];
            
//            [self currentNavigationItem].rightBarButtonItem = rightBarButtonItem;
            tmpView = _updateView;
        }
            break;
        default:
            break;
    }
    if (_currentView == tmpView) {
        return;
    }
    [self.view insertSubview:tmpView aboveSubview:_currentView];
    [_currentView removeFromSuperview];
    _currentView = tmpView;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self currentNavigationItem].rightBarButtonItem = nil;
}

-(void)updateAllApps {
    if (_updateView) {
        [_updateView updateAllApps];
    }
}

-(void)pullUpadteViewTableView
{
    [_updateView.mainTableView setTableViewStateRefreshing];
    NWUpdateAppSender *sender = [[NWUpdateAppSender alloc]init];
    NWUpdateViewCacheBean *cache = [[NWUpdateViewCacheBean alloc]init];
    NWSenderResultModel *reslutModel = [sender sendUpdateChackApp];
    [self goToInsidePageWithModel:reslutModel cacheBean:cache successBlocks:^(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject) {
        _updateView.cacheBean = (NWUpdateViewCacheBean *)self.viewCacheBean;
        [_updateView updateAllApps];
    } failedBlocks:^(NSString *businessCode, NSString *errorInformation, id goToPageObject) {
        NSLog(@"failed:%@",errorInformation);
        [_updateView.mainTableView reloadDataWithIsAllLoaded:NO];
    }];
}

@end
