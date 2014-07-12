//
//  NWRootViewController.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NWNavigationBar.h"
#import "NWRootView.h"
#import "NWNavigationController.h"
#import "NWServerController.h"
#import "NWNavigationBar.h"
#import "NWStringUtil.h"
#import "NWViewCacheBean.h"

@interface NWRootViewController : UIViewController

@property (nonatomic,strong) UIView *containerView;
/** 发送服务互斥服务token */
@property (nonatomic, copy) NSString *mutexServicetoken;
/** 服务控制器 */
@property (nonatomic, strong) NWServerController *serviceController;
/** 当前页面的CacheBean */
@property (nonatomic, strong) NWViewCacheBean *viewCacheBean;

-(void)pushViewController:(NWRootViewController *)viewController animated:(BOOL)animated;

- (UINavigationItem *)currentNavigationItem;


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
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;
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
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;

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
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;
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
                 failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;

/**
 当前页面发送服服务 接口一
 
 @param model_queue            发服务方法返回model
 @param isMutex                是否互斥
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToInsidePageWithModel:(NWSenderResultModel *)model_queue
                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;
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
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;

/**
 当前页面发送服服务 原始
 
 @param model_queue            发服务方法返回model
 @param isMutex                是否互斥
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
// */
- (void)goToInsidePageWithModel:(NWSenderResultModel *)model_queue
                 withMutaxArray:(NSArray *)mutaxTokenArray
                      cacheBean:(NWViewCacheBean *)cacheBean
                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;

-(void)registerLoadingView;
-(void)registerView:(NSString *)token;
-(void)removeLoadingView:(NSString *)token;
-(void)cancelAllService;

-(void)adjustTableView:(UITableView *)tableView
          offsetHeight:(CGFloat)offsetHeight;
- (void)adjustStatusBar;

@end
