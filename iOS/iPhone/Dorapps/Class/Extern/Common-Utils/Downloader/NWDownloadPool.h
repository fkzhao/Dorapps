//
//  NWDownloadPool.h
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWAppDownloader.h"
#import "NWDownloaderDelegate.h"

@interface NWDownloadPool : NSObject

@property (retain, nonatomic) NSMutableArray* pool;
+ (NWDownloadPool *)downloadPool;
-(NWAppDownloader*) addNewDownloadFromURL:(NSString*) url withDelegate:(id<NWDownloaderDelegate>) delegate;

-(void)setDownloadDelegate:(NSString *)url withDelegate:(id<NWDownloaderDelegate>) delegate;
-(void) cancelAllDownloads;
-(void) cancelDownloadByURL:(NSString*) url;
-(void) cancelDownloadByTag:(NSInteger) tag;


@end
