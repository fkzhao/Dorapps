//
//  NWDownloader.h
//  APPVV
//
//  Created by Anselz on 14-6-29.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWDownloadProtocol.h"
#import "NWFileManagerUtil.h"

@interface NWDownloader : NSObject

/*!
 *  开始新的下载
 *
 *  @param str      下载URL
 *  @param delegate 代理
 *
 *  @return token
 */
+(NSString *)addDownloader:(NSString *)str withDelegate:(id<NWDownloaderDelegate>) delegate;

/*!
 *  断点下载
 *
 *  @param str         下载URL
 *  @param currentSize 当前已下载大小
 *  @param delegate    代理
 *
 *  @return token
 */
+(NSString *)addDownloader:(NSString *)str withSize:(CGFloat)currentSize withDelegate:(id<NWDownloaderDelegate>) delegate;
/*!
 *  取消下载
 *
 *  @param token token
 */
+(void)cancelDownloadingTask:(NSString *)token;

/*!
 *  停止下载（效果和Cancel一样）
 *
 *  @param token token
 */
+(void)stopDownloadingTask:(NSString *)token;


#pragma mark - --------------------I/O操作不用--------------------
+(void)createFolderWithToken:(NSString *)token;

+(void)removeFolderWithToken:(NSString *)token;

+(NSData *)readDataWithToken:(NSString *)token;

+(void)writeDataWithToken:(NSString *)token;
@end
