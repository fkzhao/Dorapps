//
//  NWDownloaderDelegate.h
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

@class NWAppDownloader;

@protocol NWDownloaderDelegate <NSObject>

@optional
-(void) didStartDownload:(NWAppDownloader *) downloaderInst;
-(void) didDownloadFailed:(NWAppDownloader *) downloaderInst withError:(NSString *) error;
-(void) didDownloadCancel:(NWAppDownloader *) downloaderInst;
-(void) didFinishDownload:(NWAppDownloader *) downloaderInst;
-(void) didProgressDownload:(NWAppDownloader *) downloaderInst withPercents:(NSNumber *) percents;

@end

