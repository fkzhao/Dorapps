//
//  NWViewCacheBeanPool.h
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NWViewCacheBean;

@interface NWViewCacheBeanPool : NSObject

+(instancetype)defaultCacheBeanPool;

-(void)setViewCacheBean:(NWViewCacheBean *)cacheBean withToken:(NSString *)token;

-(NWViewCacheBean *)getViewCacheBean:(NSString *)token;

-(void)removeViewCacheBean:(NSString *)token;

@end
