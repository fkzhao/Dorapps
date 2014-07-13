//
//  NWDownloadCenter.h
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWListAppModel.h"
/*!
 *  下载中心
 */
@interface NWDownloadCenter : NSObject

/*!
 *  获取单例
 *
 *  @return NWDownloadCenter 单例对象
 */
+(instancetype)defaultCenter;

/*!
 *  同步数据到CoreData
 *
 *  @return BOOL 是否同步成功
 */
-(BOOL)synchronize;

/*!
 *  添加下载任务
 *
 *  @param model App的模型
 */
-(void)addDownloadTask:(NWListAppModel *)model;

/*!
 *  结束任务
 *
 *  @param token token
 */
-(void)finishDownloadTask:(NSString *)token;

/*!
 *  获取所有下载任务
 */
-(void)fetchAllDownloadTask;

/*!
 *  获取所有已下载任务
 */
-(void)fetchAllDownloadedTask;

/*!
 *  获取所有正在下载任务
 */
-(void)fetchAllDownloadingTask;

/*!
 *  移除下载任务
 *
 *  @param model App模型
 */
-(void)removeDownloadTask:(NWListAppModel *)model;

/*!
 *  暂停下载任务
 *
 *  @param model App模型
 */
-(void)cancelDownloadTask:(NWListAppModel *)model;
@end
