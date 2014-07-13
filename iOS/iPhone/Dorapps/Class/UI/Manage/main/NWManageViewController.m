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

@interface NWManageViewController ()
{
    UIView *_currentView;
}
@property (nonatomic,strong) NWDownloadedView *downloadedView;
@property (nonatomic,strong) NWDownloadingView *downloadingView;
@property (nonatomic,strong) NWInstalledView *installedView;
@property (nonatomic,strong) NWUpdateView *updateView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

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
    self.title = [NWStringUtil getLocalizationString:LocationFlag_Title_MANAGER];
    if (_segmentControl) {
        [_segmentControl setTitle:[NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Downloading] forSegmentAtIndex:0];
        [_segmentControl setTitle:[NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Downloaded] forSegmentAtIndex:1];
        [_segmentControl setTitle:[NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Installed] forSegmentAtIndex:2];
        [_segmentControl setTitle:[NWStringUtil getLocalizationString:LocationFlag_UIViewController_Manager_Update] forSegmentAtIndex:3];
    }
    if (!_downloadedView) {
        _downloadedView = [[NWDownloadedView alloc]initWithFrame:CGRectMake(0, 28, 320, self.view.frame.size.height - 28)];
    }
    if (!_downloadingView) {
         _downloadingView = [[NWDownloadingView alloc]initWithFrame:CGRectMake(0, 28, 320, self.view.frame.size.height - 28)];
    }
    if (!_installedView) {
        _installedView = [[NWInstalledView alloc]initWithFrame:CGRectMake(0, 28, 320, self.view.frame.size.height - 28)];
    }
    if (!_updateView) {
        _updateView = [[NWUpdateView alloc]initWithFrame:CGRectMake(0, 28, 320, self.view.frame.size.height - 28)];
    }
    _currentView = _downloadingView;
    [self.view addSubview:_currentView];
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
- (IBAction)segmentChange:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
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
            UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新全部" style:UIBarButtonItemStylePlain target:self action:@selector(updateAllApps)];
            [self currentNavigationItem].rightBarButtonItem = rightBarButtonItem;
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

-(void)updateAllApps {
    if (_updateView) {
        [_updateView updateAllApps];
    }
}


@end
