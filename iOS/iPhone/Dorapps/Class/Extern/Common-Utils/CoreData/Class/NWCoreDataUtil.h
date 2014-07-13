//
//  NWCoreDataUtil.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-4.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NWDownloadApps.h"

@interface NWCoreDataUtil : NSObject
#pragma mark - --------------------全局--------------------
/*!
 *  数据持久化方法
 */
+(void)saveContext;

#pragma mark - --------------------下载应用接口--------------------
/*!
 *  插入下载App数据
 *
 *  @param item 下载数据实例
 */
+(void)insertDownloadAppItem:(NWDownloadApps *)item;

/*!
 *  获取所有下载数据
 *
 *  @param block 结果回调
 */
+(void)fetchAllDownloadAppItem:(void(^)(NSArray *downloadApps))block;

/*!
 *  根据条件获取数据
 *
 *  @param key   条件key
 *  @param value 条件Value
 *  @param block 结果回调
 */
+(void)fetchDownloadAppItem:(NSString *)key withValue:(NSString *)value withBlock:(void(^)(NSArray *downloadApps))block;

/*!
 *  删除符合条件接口
 *
 *  @param key   条件key
 *  @param value 条件Value
 */
+(void)deleteDownloadItem:(NSString *)key withValue:(NSString *)value;

/*!
 *  删除所有数据
 */
+(void)deleteDownloadAllItem;

/*!
 *  更新下载软件
 *
 *  @param item  需要更新对象
 *  @param key   条件key
 *  @param value 条件Value
 */
+(void)updateDownloadItem:(NWDownloadApps *)item withKey:(NSString *)key withValue:(NSString *)value;

/*!
 *  获取下载应用数
 *
 *  @param block 结果回调
 */
+(void)fetchDownloadItemNumberOfRow:(void (^)(NSInteger count))block;

/*!
 *  根据条件获取下载数据
 *
 *  @param block 结果回调
 *  @param key   条件key
 *  @param value 条件Value
 */
+(void)fetchDownloadItemNumberOfRow:(void (^)(NSInteger count))block withKey:(NSString *)key withValue:(NSString *)value;

#pragma mark - --------------------其他接口 占位符--------------------
@end
