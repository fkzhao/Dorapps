//
//  NWDownloadPool.h
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWDownloadProtocol.h"

@class NWDownloadModel;
@interface NWDownloadPool : NSOperation

@property (nonatomic,strong) NSOperationQueue *operationQueue;
+(instancetype)defaultDownloader;

-(NSString *)addDownloadTaskWith:(NSString *)url withDelegate:(id<NWDownloaderDelegate>)delegate;

-(void)cancelDownloadTaskWith:(NSString *)token;

-(void)setDownloadModel:(NSString *)token withModel:(NWDownloadModel *)newModel;

-(NWDownloadModel *)getDownloadModel:(NSString *)token;


-(void)downloadFinished:(NSString *)token withData:(NSData *)data;

@end
