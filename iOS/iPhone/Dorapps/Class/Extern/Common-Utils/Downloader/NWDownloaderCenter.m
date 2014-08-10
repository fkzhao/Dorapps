//
//  NWDownloaderCenter.m
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloaderCenter.h"

@implementation NWDownloaderCenter

-(id)init
{
    self = [super init];
    if (self) {
        self.downloadingArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.waitingArray = [[NSMutableArray alloc]initWithCapacity:0];
        _maxDownloader = 2;
    }
    return self;
}
/*!
 *  单例下载中心
 *
 *  @return NWDownloader
 */
+(instancetype)defaultCenter
{
    static NWDownloaderCenter *defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[self alloc]init];
    });
    return defaultCenter;
}

/*!
 *  添加下载任务
 *
 *  @param url      下载URL
 *  @param delegate 代理
 */
+(void)addDownloadTask:(NSString *)url withDelegate:(id<NWDownloaderDelegate>)delegate
{
    NWDownloaderCenter *center = [NWDownloaderCenter defaultCenter];
    if ([center.downloadingArray containsObject:url]) {
        return;
    }
    if (center.downloadingArray.count >= center.maxDownloader) {
        [center.waitingArray addObject:url];
        return;
    }
    NWDownloadPool *pool = [NWDownloadPool downloadPool];
    [pool addNewDownloadFromURL:url withDelegate:delegate];
    
}

/*!
 *  取消下载任务
 *
 *  @param url 下载的URL
 */
+(void)cancelDownloadTask:(NSString *)url
{
    NWDownloaderCenter *center = [NWDownloaderCenter defaultCenter];
    if ([center.downloadingArray containsObject:url]) {
        return;
    }
    if ([center.waitingArray containsObject:url]) {
        [center.waitingArray removeObject:url];
    }
}

@end
