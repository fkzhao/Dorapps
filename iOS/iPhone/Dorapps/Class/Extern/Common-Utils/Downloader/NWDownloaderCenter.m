//
//  NWDownloaderCenter.m
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloaderCenter.h"
#import "NWDowloadModel.h"

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
    if (center.downloadingArray.count > 0) {
        return;
    }
    if ([center.downloadingArray containsObject:url]) {
        return;
    }
    if (center.downloadingArray.count >= center.maxDownloader) {
        [center.waitingArray addObject:url];
        return;
    }
    NWDownloadPool *pool = [NWDownloadPool downloadPool];
    [pool addNewDownloadFromURL:url withDelegate:delegate];
    NWDowloadModel *model = [[NWDowloadModel alloc]init];
    model.downloadURL = @"http://dl.appvv.com/2d804d1d5bc6bbe479c841ac562ccb77c6b3d423.ipa?st=2j1yhJGxEFUlEH_teNfNCg&e=1408630559";
    model.appName = @"Twitter";
    model.appVersion = @"6.11";
    model.appSize = @"18.79MB";
    model.appIcon = @"http://pic.appvv.com/8e654ea89ddc47f343d9714be46e71a4/175.png";
    [center.downloadingArray addObject:model];
}

/*!
 *  添加下载任务
 *
 *  @param model      下载Model
 *  @param delegate 代理
 */
+(void)addDownloadTaskWith:(NWDowloadModel *)model withDelegate:(id<NWDownloaderDelegate>)delegate
{
     NWDownloadPool *pool = [NWDownloadPool downloadPool];
    [pool setDownloadDelegate:model.downloadURL withDelegate:delegate];
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
        return;
    }
    NWDownloadPool *pool = [NWDownloadPool downloadPool];
    [pool cancelDownloadByURL:url];
}

/*!
 *  取消下载任务
 *
 *  @param model 下载的Model
 */
+(void)cancelDownloadTaskWith:(NWDowloadModel *)model
{
    
}
@end
