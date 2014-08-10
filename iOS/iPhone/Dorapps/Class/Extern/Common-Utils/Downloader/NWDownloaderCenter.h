//
//  NWDownloaderCenter.h
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWDownloadPool.h"

/*!
 *  下载中心
 */
@interface NWDownloaderCenter : NSObject

@property (nonatomic,readonly) NSInteger maxDownloader;

/*!
 *  已下载的队列
 */
@property (nonatomic,strong) NSMutableArray *downloadedArray;

/*!
 *  正在下载的队列
 */
@property (nonatomic,strong) NSMutableArray *downloadingArray;

/*!
 *  等待下载的队列
 */
@property (nonatomic,strong) NSMutableArray *waitingArray;

/*!
 *  单例下载中心
 *
 *  @return NWDownloader
 */
+(instancetype)defaultCenter;

/*!
 *  添加下载任务
 *
 *  @param url      下载URL
 *  @param delegate 代理
 */
+(void)addDownloadTask:(NSString *)url withDelegate:(id<NWDownloaderDelegate>)delegate;

/*!
 *  取消下载任务
 *
 *  @param url 下载的URL
 */
+(void)cancelDownloadTask:(NSString *)url;

@end
