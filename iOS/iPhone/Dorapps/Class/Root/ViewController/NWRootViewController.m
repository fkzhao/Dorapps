//
//  NWRootViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWRootViewController.h"
#import "NWAppDelegate.h"
#import "NWDetailViewController.h"
#import "CTLoadingView.h"
#import "NWTabBarViewController.h"
#import "NWViewCacheBeanManager.h"

@interface NWRootViewController ()

@end

@implementation NWRootViewController
@synthesize containerView = containerView_;
@synthesize serviceController = serviceController_;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initBaseData];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseView];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)initBaseData{
    serviceController_ = [[NWServerController alloc]init];
    serviceController_.owner = self;
    self.mutexServicetoken = @"";
}

#pragma mark 初始化视图
- (void)initBaseView
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)pushViewController:(NWRootViewController *)viewController animated:(BOOL)animated {
    NWAppDelegate *delegate = (NWAppDelegate *)[UIApplication sharedApplication].delegate;
    NWNavigationController *navigationController = delegate.rootViewController;
    [navigationController  pushViewController:viewController animated:animated];
    
}

- (UINavigationItem *)currentNavigationItem; {
    NWAppDelegate *delegate = (NWAppDelegate *)[UIApplication sharedApplication].delegate;
    NWTabBarViewController *tabbarViewController = delegate.mainViewController;
    return tabbarViewController.navigationItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - --------------------代理方法--------------------

#pragma mark - 到下一页发送服务接口
/**
 进入下一级页面 接口一
 
 @param model_queue            发服务方法返回model
 @param cacheBean              跳转前页面CacheBean对象
 @param saveParam              CacheBean对象save方法参数
 @param nextClass              跳转下一个页面的对象类型
 @param isGoBackAfterCancel    取消后是否返回上级页面
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToNextPageWithModel:(NWSenderResultModel *)model_queue
                    cacheBean:(NWViewCacheBean *)cacheBean
                    saveParam:(NSString *)saveParam
                nextPageClass:(Class)nextClass
                successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    [self goToNextPageWithModel:model_queue withMutaxArray:nil cacheBean:cacheBean saveParam:saveParam nextPageClass:nextClass successBlocks:sBlocks failedBlocks:fBlocks];
}

/**
 进入下一级页面 带互斥 接口二
 
 @param model_queue            发服务方法返回model
 @param cacheBean              跳转前页面CacheBean对象
 @param saveParam              CacheBean对象save方法参数
 @param nextClass              跳转下一个页面的对象类型
 @param isGoBackAfterCancel    取消后是否返回上级页面
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToNextPageWithModel:(NWSenderResultModel *)model_queue
               withMutaxArray:(NSArray *)mutaxTokenArray
                    cacheBean:(NWViewCacheBean *)cacheBean
                    saveParam:(NSString *)saveParam
                nextPageClass:(Class)nextClass
                successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    [self goToNextPageWithModel:model_queue withMutaxArray:mutaxTokenArray cacheBean:cacheBean saveParam:saveParam nextPageClass:nextClass createNextPageCache:^NWViewCacheBean *{
        return nil;
    } successBlocks:sBlocks failedBlocks:fBlocks];
}

/**
 进入下一级页面 接口三
 mutextTokenArray = nil;isShowLoading = YES;isShowCancel = YES;isShowErrorInfo = YES;animateType = eAnimateTypeControllerPush;
 
 @param model_queue            发服务方法返回model
 @param cacheBean              跳转前页面CacheBean对象
 @param saveParam              CacheBean对象save方法参数
 @param nextClass              跳转下一个页面的对象类型
 @param isGoBackAfterCancel    取消后是否返回上级页面
 @param createBlock            创建下个页面所使用的Cache
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToNextPageWithModel:(NWSenderResultModel *)model_queue
                    cacheBean:(NWViewCacheBean *)cacheBean
                    saveParam:(NSString *)saveParam
                nextPageClass:(Class)nextClass
          createNextPageCache:(NWViewCacheBean *(^)(void))createBlock
                successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    [self goToNextPageWithModel:model_queue withMutaxArray:nil cacheBean:cacheBean saveParam:saveParam nextPageClass:nextClass createNextPageCache:createBlock successBlocks:sBlocks failedBlocks:fBlocks];
}
/**
 进入下一级页面 原始接口（也可以做互斥接口）
 mutextTokenArray = nil;isShowLoading = YES;isShowCancel = YES;isShowErrorInfo = YES;animateType = eAnimateTypeControllerPush;
 
 @param model_queue            发服务方法返回model
 @param cacheBean              跳转前页面CacheBean对象
 @param saveParam              CacheBean对象save方法参数
 @param nextClass              跳转下一个页面的对象类型
 @param isGoBackAfterCancel    取消后是否返回上级页面
 @param createBlock            创建下个页面所使用的Cache
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToNextPageWithModel:(NWSenderResultModel *)model_queue
               withMutaxArray:(NSArray *)mutaxTokenArray
                    cacheBean:(NWViewCacheBean *)cacheBean
                    saveParam:(NSString *)saveParam
                nextPageClass:(Class)nextClass
          createNextPageCache:(NWViewCacheBean *(^)(void))createBlock
                successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks{
    [self.serviceController goTargetWithModel:model_queue withMutaxArray:mutaxTokenArray cacheBean:cacheBean saveParam:saveParam nextPageCahceBean:createBlock() nextPageClass:nextClass successBlocks:sBlocks failedBlocks:fBlocks];
}



#pragma makr - 当前页面发送服务接口
/**
 当前页面发送服服务 接口一
 
 @param model_queue            发服务方法返回model
 @param isMutex                是否互斥
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToInsidePageWithModel:(NWSenderResultModel *)model_queue
                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    [self goToInsidePageWithModel:model_queue cacheBean:self.viewCacheBean successBlocks:sBlocks failedBlocks:fBlocks];
}
/**
 当前页面发送服服务 接口二
 
 @param model_queue            发服务方法返回model
 @param isMutex                是否互斥
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToInsidePageWithModel:(NWSenderResultModel *)model_queue
                      cacheBean:(NWViewCacheBean *)cacheBean
                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    [self goToInsidePageWithModel:model_queue withMutaxArray:nil cacheBean:cacheBean successBlocks:sBlocks failedBlocks:fBlocks];
}

/**
 当前页面发送服服务 原始
 
 @param model_queue            发服务方法返回model
 @param isMutex                是否互斥
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToInsidePageWithModel:(NWSenderResultModel *)model_queue
                 withMutaxArray:(NSArray *)mutaxTokenArray
                      cacheBean:(NWViewCacheBean *)cacheBean
                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks
{
    self.viewCacheBean = cacheBean;
    [NWViewCacheBeanManager setViewCacheBean:self.viewCacheBean withToken:model_queue.resultToke];
    [self.serviceController goToInsidePageWithModel:model_queue withMutaxArray:mutaxTokenArray successBlocks:sBlocks failedBlocks:fBlocks];
}



#pragma mark - 注册转圈
-(void)registerLoadingView{
    [self registerView:@"loading"];
}
-(void)registerView:(NSString *)token{
    [CTLoadingView showInView:self.view withToken:token];
}

-(void)removeLoadingView:(NSString *)token{
    [CTLoadingView removeFromView:self.view withToken:token];
}
- (void)adjustStatusBar {
    
}

-(void)cancelAllService{
    [self.serviceController cancelAllService];
}

-(void)adjustTableView:(UITableView *)tableView
          offsetHeight:(CGFloat)offsetHeight
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        return;
    }
//    if (self.navigationBar.isHidden) {
//        return;
//    }
//    if ([tableView isKindOfClass:[CTTableView class]]) {
//        return;
//    }
//    int defaultNavBarHeight = 20+(self.navigationBar.isHidden ? 0 : 44);
//    
//    CGFloat offsetTop = offsetHeight + defaultNavBarHeight;
//    tableView.frame = CGRectMake(0, -defaultNavBarHeight, tableView.bounds.size.width, tableView.bounds.size.height + defaultNavBarHeight+offsetHeight);
//    tableView.contentInset = UIEdgeInsetsMake(offsetTop, 0, 0, 0);
//    [tableView setScrollIndicatorInsets:UIEdgeInsetsMake(offsetTop, 0, 0, 0)];
}
@end
