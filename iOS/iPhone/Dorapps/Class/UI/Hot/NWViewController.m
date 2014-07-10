//
//  NWViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-21.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWViewController.h"
#import "NWTableView.h"
#import "NWHotTableViewCell.h"
#import "NWRefreshControl.h"

@interface NWViewController ()<NWTableViewDelegate,NWRefreshControlDelegate>

@property (weak, nonatomic) IBOutlet NWTableView *mainTable;
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (nonatomic,strong) NWRefreshControl *refreshControl;
@end

@implementation NWViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainTable.updateDelegate = self;
    
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]]];
    self.refreshControl =  [[NWRefreshControl alloc] initWithScrollView:self.mainWebView.scrollView delegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NWHotTableViewCell *cell = (NWHotTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWHotTableViewCell class])];
    if (cell == nil) {
        cell = (NWHotTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NWHotTableViewCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    return cell;
}



- (void)pullDownToRefreshData:(NWTableView *)tableView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTable reloadDataWithRefreshingIsAllLoaded:NO];
        });
    });

    
}
- (void)pullUpToAddData:(NWTableView *)tableView {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTable reloadDataWithLoadMoreIsAllLoaded:NO];
        });
    });

}


#pragma mark - NWRefreshControl Delegate

- (BOOL)isLoading {
    return YES;
}

- (void)beginPullDownRefreshing {
}

- (void)beginLoadMoreRefreshing {
    
}

- (NSDate *)lastUpdateTime {
    return [NSDate date];
}

- (BOOL)keepiOS7NewApiCharacter {
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

- (NSInteger)autoLoadMoreRefreshedCountConverManual {
    return 2;
}

- (BOOL)isPullDownRefreshed {
    return YES;
}

- (BOOL)isLoadMoreRefreshed {
    return YES;
}

- (NWRefreshViewLayerType)refreshViewLayerType {
    return NWRefreshViewLayerTypeOnScrollViews;
}
@end
