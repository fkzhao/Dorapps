//
//  NWViewCacheBeanPool.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWViewCacheBeanPool.h"
#import "NWViewCacheBeanBlock.h"

@interface NWViewCacheBeanPool ()

@property (nonatomic,strong)NSMutableDictionary *cacheBeanPool;

@end

@implementation NWViewCacheBeanPool

+(instancetype)defaultCacheBeanPool
{
    static NWViewCacheBeanPool *defaultPool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultPool = [[self alloc]init];
    });
    return defaultPool;
}


-(id)init
{
    self = [super init];
    if (self) {
        self.cacheBeanPool = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(void)setViewCacheBean:(NWViewCacheBean *)cacheBean withToken:(NSString *)token
{
    if ([self.cacheBeanPool.allKeys containsObject:token]) {
        NWViewCacheBeanBlock *block = (NWViewCacheBeanBlock *)[self.cacheBeanPool objectForKey:token];
        [block putViewCacheBean:cacheBean];
    } else {
        NWViewCacheBeanBlock *block = [[NWViewCacheBeanBlock alloc]init];
        [self.cacheBeanPool setObject:block forKey:token];
        [block putViewCacheBean:cacheBean];
    }
}

-(NWViewCacheBean *)getViewCacheBean:(NSString *)token
{
    id cacheBean;
    NWViewCacheBeanBlock *block = nil;
    if (![self.cacheBeanPool.allKeys containsObject:token]) {
         block = [[NWViewCacheBeanBlock alloc]init];
        [self.cacheBeanPool setObject:block forKey:token];
    } else {
        block = (NWViewCacheBeanBlock *)[self.cacheBeanPool objectForKey:token];
    }
    cacheBean = [block getViewCacheBean];
    [self removeViewCacheBean:token];
    return cacheBean;
}

-(void)removeViewCacheBean:(NSString *)token
{
    @synchronized(self) {
        if ([self.cacheBeanPool.allKeys containsObject:token]) {
            [self.cacheBeanPool removeObjectForKey:token];
        }
    }
}
@end
