//
//  CTServerController.h
//  STAYREAL
//
//  Created by Ansel on 13-7-20.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWNavigationController.h"
#import "CTSenderResultModel.h"
#import "CTViewCacheBean.h"
#import "CTViewCacheManage.h"

#define SUCCESSBLOCKKEY     @"sBlocks"
#define FAILEDBLOCKKEY      @"fBlocks"
@class NWRootViewController;
/* 服务控制器**/
@interface CTServerController : NSObject<UIAlertViewDelegate>{
    NSMutableDictionary *blockDictionary;
}
/* 服务控制器的拥有者**/
@property (nonatomic,weak) NWRootViewController *owner;
/** 下一个页面*/
@property (nonatomic,weak) NWRootViewController *nextPage;


/**
 进入下一级页面 接口
 mutextTokenArray = nil;isShowLoading = YES;isShowCancel = YES;isShowErrorInfo = YES;animateType = eAnimateTypeControllerPush;
 
 @param model_queue            发服务方法返回model
 @param cacheBean              跳转前页面CacheBean对象
 @param saveParam              CacheBean对象save方法参数
 @param nextClass              跳转下一个页面的对象类型
 @param isGoBackAfterCancel    取消后是否返回上级页面
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goTargetWithModel:(CTSenderResultModel *)model_queue
           withMutaxArray:(NSArray *)mutaxTokenArray
                cacheBean:(CTViewCacheBean *)cacheBean
                saveParam:(NSString *)saveParam
        nextPageCahceBean:(CTViewCacheBean *)nextPageCahceBean
            nextPageClass:(Class)nextClass
            successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
             failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;



/**
 当前页面发送服服务
 
 @param model_queue            发服务方法返回model
 @param sBlocks                服务成功回调模块
 @param fBlocks                服务失败回调模块
 */
- (void)goToInsidePageWithModel:(CTSenderResultModel *)model_queue
                 withMutaxArray:(NSArray *)mutaxTokenArray
                  successBlocks:(void (^)(NSString *businessCode, NSUInteger subServiceCount, id goToPageObject))sBlocks
                   failedBlocks:(void (^)(NSString *businessCode, NSString *errorInformation, id goToPageObject))fBlocks;


/**
 	取消服务
 
    @param 不需要参数
    
    @return 不需要返回值
 */
-(void)cancelAllService;
/**
 取消服务
 
 @param token  线程的token
 
 @return 不需要返回值
 */
-(void)cancelService:(NSString *)token;
@end
