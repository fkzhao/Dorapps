//
//  NWSearchViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWSearchViewController.h"
#import "NWHotTableViewCell.h"
#import "NWHotSender.h"
#import "NWDetailViewCacheBean.h"
#import "NWDetailViewController.h"

@interface NWSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@end

@implementation NWSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:[NWStringUtil getLocalizationString:LocationFlag_Title_SEARCH]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if ([self currentNavigationController].navigationBar.hidden) {
        return UIStatusBarStyleBlackTranslucent;
    } else {
        return UIStatusBarStyleBlackOpaque;
    }
}

#pragma mark UISearchBar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self showSearchBar:searchBar] ;
    return YES ;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        [self updateView];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self hideSearchBar:searchBar];
    [self filterCityWithString:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [self hideSearchBar:searchBar] ;
}

- (void) showSearchBar:(UISearchBar *)searchBar {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [[self currentNavigationController] setNavigationBarHidden:YES animated:YES];
    [searchBar setShowsCancelButton:YES animated:YES] ;
    [UIView animateWithDuration:0.1 animations:^{
        self.searchBar.frame = CGRectMake(0, 20, 320, searchBar.frame.size.height);
        self.mainTableView.frame = CGRectMake(0, 20+searchBar.frame.size.height, 320, self.mainTableView.frame.size.height);
    }];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void) hideSearchBar:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder] ;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [[self currentNavigationController] setNavigationBarHidden:NO animated:YES];
    [searchBar setShowsCancelButton:NO animated:YES] ;
    [UIView animateWithDuration:0.1 animations:^{
        searchBar.frame = CGRectMake(0, 0, 320, searchBar.frame.size.height);
        self.mainTableView.frame = CGRectMake(0, searchBar.frame.size.height, 320, self.mainTableView.frame.size.height);
    }];
}

- (void)filterCityWithString:(NSString*)string {
    if (string.length == 0) {
        return;
    }
}
-(void)updateView
{
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hideSearchBar:self.searchBar];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NWHotTableViewCell *cell = (NWHotTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWHotTableViewCell class])];
    if (cell == nil) {
        cell = (NWHotTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NWHotTableViewCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    NWListAppModel *model = [[NWListAppModel alloc]init];
    model.appTrackName = @"WeChat";
    model.appIcon = @"http://a291.phobos.apple.com/us/r30/Purple/v4/e8/38/c4/e838c443-06e6-af21-5533-b6ab103d7cfe/mzl.oighyogu.114x114-75.png";
    model.appSize = @"34.00MB";
    model.appVersion = @"5.2.0.19";
    model.appRating = @"4";
    model.appSort = @"0";
    model.appID = @"52c4fbb2c3b951638a9d63c6";
    [cell displayCellWith:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NWHotSender *sender = [[NWHotSender alloc]init];
    NWSenderResultModel *resultModel = [sender sendGetAppDetail:@"52c4fbb2c3b951638a9d63c6"];
    [self goToNextPageWithModel:resultModel cacheBean:nil saveParam:nil nextPageClass:[NWDetailViewController class] createNextPageCache:^NWViewCacheBean *{
        return [[NWDetailViewCacheBean alloc]init];
    } successBlocks:^(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject) {
        NWDetailViewController *detail = (NWDetailViewController *)goToPageObject;
        [detail reloadView];
    } failedBlocks:^(NSString *businessCode, NSString *errorInformation, id goToPageObject) {
        
    }];

}
@end
