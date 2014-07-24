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
#import "NWHotSender.h"
#import "NWHotViewCacheBean.h"
#import "NWDetailViewCacheBean.h"
#import "NWBannerTableViewCell.h"
#import "NWTableView.h"
#import "NWCircleLoadingView.h"
#import "NWDownloadStatusBar.h"

@interface NWHotViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NWHotViewCacheBean *cacheBean;
}
@property (nonatomic, strong) NWCircleLoadingView *loadingView;
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
//    self.viewCacheBean = [[NWHotViewCacheBean alloc]init];
}

-(void)initView {
    
    self.loadingView = [[NWCircleLoadingView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.loadingView.lineColor = NWColorRGB(255, 255, 255);
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.loadingView];
    [self currentNavigationItem].leftBarButtonItem = leftBarButtonItem;
    
    
    [self.loadingView startAnimation];
    [self.mainTableView setTableViewStateRefreshing];
    NWHotSender *sender = [[NWHotSender alloc]init];
    NWHotViewCacheBean *cache = [[NWHotViewCacheBean alloc]init];
    NWSenderResultModel *reslutModel = [sender sendGetHotAppList];
    [self goToInsidePageWithModel:reslutModel cacheBean:cache successBlocks:^(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject) {
        cacheBean = (NWHotViewCacheBean *)self.viewCacheBean;
        [self.mainTableView reloadDataWithIsAllLoaded:NO];
        [self.loadingView stopAnimation];
    } failedBlocks:^(NSString *businessCode, NSString *errorInformation, id goToPageObject) {
        NSLog(@"failed");
    }];
    
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
        return 120.0f;
    }
    return 90.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NWBannerTableViewCell *cell = (NWBannerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWBannerTableViewCell class])];
        if (cell == nil) {
            cell = (NWBannerTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NWBannerTableViewCell class]) owner:nil options:nil]objectAtIndex:0];
        }
        [cell showBannerView:cacheBean.bannerListArray withClickBlock:^(NSInteger selectIndex) {
            NWBannerModel *model = [cacheBean.bannerListArray objectAtIndex:selectIndex];
            [self gotoDetailWithBannerModel:model];
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    } else {
        NWHotTableViewCell *cell = (NWHotTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWHotTableViewCell class])];
        if (cell == nil) {
            cell = (NWHotTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NWHotTableViewCell class]) owner:nil options:nil]objectAtIndex:0];
        }
        NWListAppModel *model = (NWListAppModel *)[cacheBean.appListArray objectAtIndex:indexPath.row-1];
        [cell displayCellWith:model];
        return cell;
    }
}


-(void)gotoDetailWithBannerModel:(NWBannerModel *)model
{
    NWHotSender *sender = [[NWHotSender alloc]init];
    NWSenderResultModel *resultModel = [sender sendGetAppDetail:model.appID];
    [self goToNextPageWithModel:resultModel cacheBean:nil saveParam:nil nextPageClass:[NWDetailViewController class] createNextPageCache:^NWViewCacheBean *{
        return [[NWDetailViewCacheBean alloc]init];
    } successBlocks:^(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject) {
        NWDetailViewController *detail = (NWDetailViewController *)goToPageObject;
        [detail reloadView];
    } failedBlocks:^(NSString *businessCode, NSString *errorInformation, id goToPageObject) {
        
    }];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NWListAppModel *model = (NWListAppModel *)[cacheBean.appListArray objectAtIndex:indexPath.row-1];
    NWHotSender *sender = [[NWHotSender alloc]init];
    NWSenderResultModel *resultModel = [sender sendGetAppDetail:model.appID];
    [self goToNextPageWithModel:resultModel cacheBean:nil saveParam:nil nextPageClass:[NWDetailViewController class] createNextPageCache:^NWViewCacheBean *{
        return [[NWDetailViewCacheBean alloc]init];
    } successBlocks:^(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject) {
        NWDetailViewController *detail = (NWDetailViewController *)goToPageObject;
        [detail reloadView];
    } failedBlocks:^(NSString *businessCode, NSString *errorInformation, id goToPageObject) {
        
    }];
}

- (void)pullDownToRefreshData:(NWTableView *)tableView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadDataWithIsAllLoaded:NO];
        });
    });
}

- (void)pullUpToAddData:(NWTableView *)tableView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadDataWithIsAllLoaded:YES];
        });
    });
}


-(void)selectCategoryAction:(NSInteger)selectIndex
{
    [self.loadingView startAnimation];
    [self.mainTableView setTableViewStateRefreshing];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingView stopAnimation];
            [self.mainTableView reloadDataWithIsAllLoaded:NO];
        });
    });
}

@end
