//
//  NWHotViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotViewController.h"
#import "NWDetailViewController.h"
#import "NWHotTableViewCell.h"
#import "NWViewController.h"
#import "NWHotSender.h"
#import "NWHotViewCacheBean.h"
#import "NWDetailViewCacheBean.h"
#import "NWBannerTableViewCell.h"
#import "NWTableView.h"

@interface NWHotViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NWHotViewCacheBean *cacheBean;
}
@property (weak, nonatomic) IBOutlet NWTableView *mainTableView;

@end

@implementation NWHotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:[NWStringUtil getLocalizationString:LocationFlag_Title_HOT]];
        [self initDate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initDate {
    self.viewCacheBean = [[NWHotViewCacheBean alloc]init];
}

-(void)initView {
#warning ---------ERROR----
//    NWHotSender *sender = [[NWHotSender alloc]init];
//    [self registerLoadingView];
//    NWHotViewCacheBean *cache = [[NWHotViewCacheBean alloc]init];
//    CTSenderResultModel *reslutModel = [sender sendGetHotAppList];
//    [self goToInsidePageWithModel:reslutModel cacheBean:cache successBlocks:^(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject) {
//        cacheBean = (NWHotViewCacheBean *)self.viewCacheBean;
//        [self.mainTableView reloadData];
//    } failedBlocks:^(NSString *businessCode, NSString *errorInformation, id goToPageObject) {
//        NSLog(@"failed");
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cacheBean.appListArray.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 150.0f;
    }
    return 90.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NWBannerTableViewCell *cell = (NWBannerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWBannerTableViewCell class])];
        if (cell == nil) {
            cell = (NWBannerTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NWBannerTableViewCell class]) owner:nil options:nil]objectAtIndex:0];
        }
        [cell showBannerView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    } else {
        NWHotTableViewCell *cell = (NWHotTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWHotTableViewCell class])];
        if (cell == nil) {
            cell = (NWHotTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NWHotTableViewCell class]) owner:nil options:nil]objectAtIndex:0];
        }
        NWHotAppModel *model = (NWHotAppModel *)[cacheBean.appListArray objectAtIndex:indexPath.row-1];
        [cell displayCellWith:model];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#warning ---------ERROR----
//    NWHotAppModel *model = (NWHotAppModel *)[cacheBean.appListArray objectAtIndex:indexPath.row-1];
//    NWHotSender *sender = [[NWHotSender alloc]init];
//    CTSenderResultModel *resultModel = [sender sendGetAppDetail:model.appID];
//    [self goToNextPageWithModel:resultModel cacheBean:nil saveParam:nil nextPageClass:[NWDetailViewController class] createNextPageCache:^CTViewCacheBean *{
//        return [[NWDetailViewCacheBean alloc]init];
//    } successBlocks:^(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject) {
//        NWDetailViewController *detail = (NWDetailViewController *)goToPageObject;
//        [detail reloadView];
//    } failedBlocks:^(NSString *businessCode, NSString *errorInformation, id goToPageObject) {
//        
//    }];
}

- (void)pullDownToRefreshData:(NWTableView *)tableView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadDataWithRefreshingIsAllLoaded:NO];
        });
    });
}

@end
