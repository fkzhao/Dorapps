//
//  NWViewCacheBeanManager.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWViewCacheBeanManager.h"
#import "NWViewCacheBeanPool.h"

@implementation NWViewCacheBeanManager

+ (NWViewCacheBean *)getViewCacheBean:(NSString *)token
{
    NWViewCacheBeanPool *cacheBeanPool = [NWViewCacheBeanPool defaultCacheBeanPool];
    return [cacheBeanPool getViewCacheBean:token];
}

+ (void)setViewCacheBean:(NWViewCacheBean *)cacheBean withToken:(NSString *)token
{
    NWViewCacheBeanPool *cacheBeanPool = [NWViewCacheBeanPool defaultCacheBeanPool];
    [cacheBeanPool setViewCacheBean:cacheBean withToken:token];
}
@end
