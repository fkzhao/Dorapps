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
