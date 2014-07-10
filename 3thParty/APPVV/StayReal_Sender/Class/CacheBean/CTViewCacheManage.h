//
//  CTCacheBeanManager.h
//  StayReal_Sender
//
//  Created by Ansel on 13-7-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewCacheBean.h"
#import "CTSearchCacheBean.h"
#import "CTProductListCacheBean.h"
#import "CTProductDetailCacheBean.h"

#import "CTCacheBeanResultQueue.h"

typedef enum {
    FLAG_STAYREAL_SEARCH_CACHEBEAN  = 1001,//搜索页面
    FLAG_STAYREAL_LIST_CACHEBEAN  = 1002,//列表页面
    FLAG_STAYREAL_DETAIL_CACHEBEAN  = 1003,//详情页面
    
    FLAG_STAYREAL_HOME_CACHEBEAN  = 1004,//测试
}_CACHEBEN_NAME;

/** CacheBean工厂类 */
@interface CTViewCacheManage : NSObject
{
    
}
/* 存放cacheBean的字典**/
@property(nonatomic,strong) NSMutableDictionary *cacheDict;
/* 存放cacheBean的字典**/
@property(nonatomic,strong) NSMutableDictionary *queueDict;

+(CTViewCacheManage *)shareInstance;

-(void)setCacheQueueWithToken:(NSString *)token cacheBeanQueue:(CTCacheBeanResultQueue *)queue;
-(CTCacheBeanResultQueue *)getCacheQueueWithToken:(NSString *)token;
-(void)removeCacheQueueWithToken:(NSString *)token;
/**
    通过标志位来获取ViewCache
    @param  flag 获取cache的标志位
 */
-(CTViewCacheBean *)getViewCahce:(int)flag;

/**
 清除cacheBean
 
 @prama flag cache的标志位
 
 @prama 没有返回值
 */
-(void)cleanCache:(int)flag;

/**
 清除cacheBean
 
 @prama 没有参数
 
 @prama 没有返回值
 */
-(void)cleanAllCache;

@end
