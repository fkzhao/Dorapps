//
//  NWDownloadPool.m
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadPool.h"

@implementation NWDownloadPool

@synthesize pool;

static int tagCounter=0;

+ (NWDownloadPool *)downloadPool
{
	static dispatch_once_t once;
	static NWDownloadPool *downloadManager;
	dispatch_once(&once, ^ { downloadManager = [[NWDownloadPool alloc] init]; });
	return downloadManager;
}

-(id)init{
    self=[super init];
    if(self){
        self.pool=[[NSMutableArray alloc]initWithCapacity:10];
		tagCounter=0;
    }
    return self;
}

-(NWAppDownloader *)addNewDownloadFromURL:(NSString *)url withDelegate:(id<NWDownloaderDelegate>)delegate {
    //create new downloader
    NWAppDownloader* newDownloader=[NWAppDownloader downloadFromURL:url autoStart:NO withDelegate:delegate];
	newDownloader.tag=tagCounter++;
    //find place in pool
    int i;
    for(i=0;i<[self.pool count];i++)
    {
        NWAppDownloader* downloader=((NWAppDownloader*)[self.pool objectAtIndex:i]);
        if([self.pool objectAtIndex:i]==Nil || downloader.isFinished){
            [self.pool replaceObjectAtIndex:i withObject:newDownloader];
        }
    }
    
    //if place not founded then increment pool
    if(i==[self.pool count]){
		[self.pool addObject:newDownloader];
	}
    //start download
    [newDownloader startDownload];
    return newDownloader;
}
-(void)setDownloadDelegate:(NSString *)url withDelegate:(id<NWDownloaderDelegate>) delegate
{
    for (int i=0; i<[self.pool count]; i++) {
        NWAppDownloader* downloader=((NWAppDownloader*)[self.pool objectAtIndex:i]);
        if([downloader.downloadURL isEqualToString:url]){
            downloader.delegate = delegate;
            break;
        }
    }
}
-(void)cancelAllDownloads{
    for(int i=0;i<[self.pool count];i++)
    {
        NWAppDownloader* downloader=((NWAppDownloader*)[self.pool objectAtIndex:i]);
        if(!downloader.isFinished)
            [downloader cancelDownload];
    }
}

-(void) cancelDownloadByURL:(NSString *)url{
    for (int i=0; i<[self.pool count]; i++) {
        NWAppDownloader* downloader=((NWAppDownloader*)[self.pool objectAtIndex:i]);
        if([downloader.downloadURL isEqualToString:url]){
            [downloader cancelDownload];
            break;
        }
    }
}

-(void)cancelDownloadByTag:(NSInteger)tag{
	for (int i=0; i<[self.pool count]; i++) {
        NWAppDownloader* downloader=((NWAppDownloader*)[self.pool objectAtIndex:i]);
        if([downloader tag]==tag){
            [downloader cancelDownload];
            break;
        }
    }
}

@end
