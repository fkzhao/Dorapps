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

+(NSString *)addDownloader:(NSString *)str withDelegate:(id<NWDownloaderDelegate>) delegate;

+(void)cancelDownloadingTask:(NSString *)token;

+(void)stopDownloadingTask:(NSString *)token;

+(void)createFolderWithToken:(NSString *)token;

+(void)removeFolderWithToken:(NSString *)token;

+(NSData *)readDataWithToken:(NSString *)token;

+(void)writeDataWithToken:(NSString *)token;
@end
