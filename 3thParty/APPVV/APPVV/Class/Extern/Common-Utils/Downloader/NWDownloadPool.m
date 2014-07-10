//
//  NWDownloadPool.m
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadPool.h"
#import "NWDownloadOperation.h"
#import "NWTokenUtil.h"
#import "NWDownloadModel.h"

@interface NWDownloadPool ()

@property (nonatomic,strong) NSMutableDictionary *downloadingTasks;
@property (nonatomic,strong) NSMutableDictionary *downloadedTask;
@property (nonatomic,strong) NSMutableDictionary *downloadModels;

@end

@implementation NWDownloadPool

+(instancetype)defaultDownloader
{
    static NWDownloadPool *shareObj = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareObj = [[self alloc] init];
    });
    return shareObj;
}

-(id) init
{
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc]init];
        self.operationQueue.maxConcurrentOperationCount = 5;
        self.downloadingTasks = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.downloadedTask = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.downloadModels = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(NSString *)addDownloadTaskWith:(NSString *)url withDelegate:(id<NWDownloaderDelegate>)delegate
{
     @synchronized(self) {
         NSString *token = [NWTokenUtil createToken];
         NWDownloadModel *model = [[NWDownloadModel alloc]init];
         [self.downloadModels setObject:model forKey:token];
         NWDownloadOperation *task = [[NWDownloadOperation alloc]initWith:url withDelegate:delegate withToken:token];
         [self.operationQueue addOperation:task];
         [self.downloadingTasks setObject:task forKey:token];
         return token;
     }
}

-(void)cancelDownloadTaskWith:(NSString *)token
{
    @synchronized(self) {
        if ([[self.downloadingTasks allKeys] containsObject:token]) {
            NWDownloadOperation *task = (NWDownloadOperation *)[self.downloadingTasks objectForKey:token];
            [task cancel];
        }
    }
}

-(void)setDownloadModel:(NSString *)token withModel:(NWDownloadModel *)newModel
{
    @synchronized(self) {
        if ([[self.downloadModels allKeys] containsObject:token]) {
            NWDownloadModel *model = (NWDownloadModel *)[self.downloadModels objectForKey:token];
            model.isDownloading = YES;
        }
    }
}

-(NWDownloadModel *)getDownloadModel:(NSString *)token
{
    @synchronized(self) {
        if ([[self.downloadModels allKeys] containsObject:token]) {
            NWDownloadModel *model = (NWDownloadModel *)[self.downloadModels objectForKey:token];
            return model;
        } else {
            return nil;
        }
    }
}

-(void)downloadFinished:(NSString *)token withData:(NSData *)data
{
    if ([[self.downloadModels allKeys] containsObject:token]) {
//        NWDownloadModel *model = (NWDownloadModel *)[self.downloadModels objectForKey:token];
//        [model.downloadData writeToFile:@"/Users/Anselz/Desktop/abc.mp3" atomically:YES];
    }
}
@end
