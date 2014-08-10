//
//  NWAppDownloader.h
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWDownloaderDelegate.h"
#import "Reachability.h"

/*!
 *  下载器实例
 */
@interface NWAppDownloader : NSObject<NSURLConnectionDelegate>

@property (retain, nonatomic) NSString* downloadURL;
@property (retain, nonatomic) id<NWDownloaderDelegate> delegate;
@property (retain, nonatomic) NSURLConnection* urlConnection;
@property (retain, nonatomic) NSMutableData* downloadedData;
@property (retain, nonatomic) NSURLResponse* urlResponse;
@property (retain, nonatomic) NSString* downloadFileName;
@property (nonatomic) BOOL isFinished;
@property(nonatomic,assign) int tag;

+(id) downloadFromURL:(NSString *) anURLString autoStart:(BOOL) autostart withDelegate:(id<NWDownloaderDelegate>) delegate;
-(void) startDownload;
-(void) cancelDownload;

@end

NWAppDownloader *instance;

