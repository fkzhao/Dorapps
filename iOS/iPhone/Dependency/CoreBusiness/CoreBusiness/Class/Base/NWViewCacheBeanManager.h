//
//  NWViewCacheBeanManager.h
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NWViewCacheBean;
@interface NWViewCacheBeanManager : NSObject

+ (NWViewCacheBean *)getViewCacheBean:(NSString *)token;

+ (void)setViewCacheBean:(NWViewCacheBean *)cacheBean withToken:(NSString *)token;
@end
