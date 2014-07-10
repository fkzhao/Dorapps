//
//  NWSearchViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWSearchViewController.h"
#import "NWHotTableViewCell.h"

@interface NWSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
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
    [searchBar resignFirstResponder];
    [self filterCityWithString:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [self hideSearchBar:searchBar] ;
}

- (void) showSearchBar:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES] ;
}

- (void) hideSearchBar:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder] ;
    [searchBar setShowsCancelButton:NO animated:YES] ;
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
    [self.searchBar resignFirstResponder];
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
    NWHotAppModel *model = [[NWHotAppModel alloc]init];
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

@end
