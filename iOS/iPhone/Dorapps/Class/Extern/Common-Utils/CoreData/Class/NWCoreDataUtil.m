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
#pragma mark - --------------------全局--------------------
/*!
 *  数据持久化方法
 */
+(void)saveContext
{
    NWCoreData *coreData = [NWCoreData shareObject];
    [coreData saveContext];
}

#pragma mark - --------------------下载应用接口--------------------
/*!
 *  插入下载App数据
 *
 *  @param item 下载数据实例
 */
+(void)insertDownloadAppItem:(NWDownloadApps *)item
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakObj insertDataWith:item];
    });
}

/*!
 *  获取所有下载数据
 *
 *  @param block 结果回调
 */
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

/*!
 *  根据条件获取数据
 *
 *  @param key   条件key
 *  @param value 条件Value
 *  @param block 结果回调
 */
+(void)fetchDownloadAppItem:(NSString *)key withValue:(NSString *)value withBlock:(void(^)(NSArray *downloadApps))block{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
        NSArray *apps = [weakObj fetchDataWith:[NWDownloadApps class] withCondition:condition];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(apps);
        });
    });
}

/*!
 *  删除符合条件接口
 *
 *  @param key   条件key
 *  @param value 条件Value
 */

+(void)deleteDownloadItem:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
        [weakObj deleteDataWith:[NWDownloadApps class] withCondition:condition];
    });
}
/*!
 *  删除所有数据
 */
+(void)deleteDownloadAllItem
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakObj deleteAllDataWith:[NWDownloadApps class]];
    });
}

/*!
 *  更新下载软件
 *
 *  @param item  需要更新对象
 *  @param key   条件key
 *  @param value 条件Value
 */
+(void)updateDownloadItem:(NWDownloadApps *)item withKey:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
        [weakObj updateDataWith:item withCondition:condition];
    });
}
/*!
 *  获取下载应用数
 *
 *  @param block 结果回调
 */
+(void)fetchDownloadItemNumberOfRow:(void (^)(NSInteger count))block
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger countRow = [weakObj fetchNumberOfRow:[NWDownloadApps class]];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(countRow);
        });
    });

}

/*!
 *  根据条件获取下载数据
 *
 *  @param block 结果回调
 *  @param key   条件key
 *  @param value 条件Value
 */
+(void)fetchDownloadItemNumberOfRow:(void (^)(NSInteger count))block withKey:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    __weak NWCoreData *weakObj = coreData;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
        NSInteger countRow = [weakObj fetchNumberOfRow:[NWDownloadApps class] withCondition:condition];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(countRow);
        });
    });

}

#pragma mark - --------------------其他接口 占位符--------------------

@end
