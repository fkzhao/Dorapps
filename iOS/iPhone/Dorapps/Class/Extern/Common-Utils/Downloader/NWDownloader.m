//
//  NWDownloader.m
//  APPVV
//
//  Created by Anselz on 14-6-29.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloader.h"
#import "NWDownloadPool.h"
#import "NWDownloadModel.h"

@implementation NWDownloader

+(NSString *)addDownloader:(NSString *)str withDelegate:(id<NWDownloaderDelegate>) delegate
{
    NWDownloadPool *obj = [NWDownloadPool defaultDownloader];
    NSString *token = [obj addDownloadTaskWith:str withDelegate:delegate];
    return token;
}

/*!
 *  断点下载
 *
 *  @param str         下载URL
 *  @param currentSize 当前已下载大小
 *  @param delegate    代理
 *
 *  @return token
 */
+(NSString *)addDownloader:(NSString *)str withSize:(CGFloat)currentSize withDelegate:(id<NWDownloaderDelegate>) delegate
{
    NSLog(@"No implementation function.");
    return @"";
}

+(void)cancelDownloadingTask:(NSString *)token
{
    NWDownloadPool *obj = [NWDownloadPool defaultDownloader];
    [obj cancelDownloadTaskWith:token];
}

+(void)stopDownloadingTask:(NSString *)token
{
    [self cancelDownloadingTask:token];
}

+(void)createFolderWithToken:(NSString *)token
{
    [NWFileManagerUtil createFolder:[NWFileManagerUtil getDownloaderItemPath:token]];
}

+(void)removeFolderWithToken:(NSString *)token
{
    [NWFileManagerUtil removeFolder:[NWFileManagerUtil getDownloaderItemPath:token]];
}

+(NSData *)readDataWithToken:(NSString *)token
{
    return nil;
}

+(void)writeDataWithToken:(NSString *)token
{
    
}

@end
