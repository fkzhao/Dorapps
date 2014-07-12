//
//  NWCoreDataUtil.m
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-4.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWCoreDataUtil.h"
#import "NWCoreData.h"

@implementation NWCoreDataUtil

+(void)saveContext
{
    NWCoreData *coreData = [NWCoreData shareObject];
    [coreData saveContext];
}

+(void)insertDownloadAppItem:(NWDownloadApps *)item
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakObj insertDataWith:item];
    });
}

+(void)fetchAllDownloadAppItem:(void(^)(NSArray *downloadApps))block
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *apps = [weakObj fetchAllDataWith:[NWDownloadApps class]];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(apps);
        });
    });
}

+(void)fetchDownloadAppItem:(NSString *)key withValue:(NSString *)value withBlock:(void(^)(NWDownloadApps *downloadApp))block{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
        NWDownloadApps *app = [weakObj fetchDataWith:[NWDownloadApps class] withCondition:condition];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(app);
        });
    });
}

+(void)deleteDownloadItem:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
        [weakObj deleteDataWith:[NWDownloadApps class] withCondition:condition];
    });
}

+(void)deleteDownloadAllItem
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakObj deleteAllDataWith:[NWDownloadApps class]];
    });
}

+(void)updateDownloadItem:(NWDownloadApps *)item withKey:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
        [weakObj updateDataWith:item withCondition:condition];
    });
}
@end
