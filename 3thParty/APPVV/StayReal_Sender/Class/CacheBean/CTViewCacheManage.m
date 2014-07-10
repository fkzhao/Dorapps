//
//  CTCacheBeanManager.m
//  StayReal_Sender
//
//  Created by Ansel on 13-7-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTViewCacheManage.h"

//单例
static CTViewCacheManage *viewCahce = nil;

@implementation CTViewCacheManage

+(CTViewCacheManage *)shareInstance{
    if (viewCahce == nil) {
        viewCahce = [[CTViewCacheManage alloc] init];
    }
    return viewCahce;
}

-(id)init{
    self = [super init];
    if (self) {
        self.cacheDict = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.queueDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(CTViewCacheBean *)getViewCahce:(int)flag{
    NSString *cachekey = [NSString stringWithFormat:@"%d",flag];
    CTViewCacheBean * cacheBean = [self.cacheDict objectForKey:cachekey];
    if(cacheBean != nil){
        return cacheBean;
    }
    switch (flag) {
        case FLAG_STAYREAL_HOME_CACHEBEAN:
        {

        }
            break;
        case FLAG_STAYREAL_SEARCH_CACHEBEAN:
        {
            cacheBean = [[CTSearchCacheBean alloc]init];
            [self.cacheDict setObject:cacheBean forKey:cachekey];
        }
            break;
        case FLAG_STAYREAL_LIST_CACHEBEAN:
        {
            cacheBean = [[CTProductListCacheBean alloc]init];
            [self.cacheDict setObject:cacheBean forKey:cachekey];
        }
            break;
        case FLAG_STAYREAL_DETAIL_CACHEBEAN:
        {
            cacheBean = [[CTProductDetailCacheBean alloc]init];
            [self.cacheDict setObject:cacheBean forKey:cachekey];
        }
            break;
        default:
            break;
    }
    return cacheBean;
}
/**
 清除cacheBean
 
 @prama flag cache的标志位
 
 @prama 没有返回值
 */
-(void)cleanCache:(int)flag{
    NSString *cachekey = [NSString stringWithFormat:@"%d",flag];
    if ([[self.cacheDict allKeys] containsObject:cachekey]) {
        [self.cacheDict removeObjectForKey:cachekey];
    }
}

/**
 清除cacheBean
 
 @prama 没有参数
 
 @prama 没有返回值
 */
-(void)cleanAllCache{
    if (self.cacheDict) {
        [self.cacheDict removeAllObjects];
    }
}

-(void)setCacheQueueWithToken:(NSString *)token cacheBeanQueue:(CTCacheBeanResultQueue *)queue{
    [self.queueDict setObject:queue forKey:token];
}
-(CTCacheBeanResultQueue *)getCacheQueueWithToken:(NSString *)token{
    CTCacheBeanResultQueue *queue = (CTCacheBeanResultQueue *)[self.queueDict objectForKey:token];
    return queue;
}
-(void)removeCacheQueueWithToken:(NSString *)token{
    [self.queueDict removeObjectForKey:token];
}
@end
