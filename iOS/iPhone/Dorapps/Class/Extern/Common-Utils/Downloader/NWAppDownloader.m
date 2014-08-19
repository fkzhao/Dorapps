//
//  NWAppDownloader.m
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWAppDownloader.h"
#import "NSURL+Filters.h"
#import "NWDownloaderCenter.h"

@implementation NWAppDownloader
@synthesize downloadURL;
@synthesize urlConnection;
@synthesize delegate;
@synthesize downloadedData;
@synthesize urlResponse;
@synthesize downloadFileName;
@synthesize isFinished,tag;

static dispatch_queue_t queue;

#pragma mark - --------------------退出清空--------------------

#pragma mark - --------------------初始化--------------------
-(id)init{
    self=[super init];
    if (self){
        queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return self;
}

#pragma mark - --------------------System--------------------

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------手势事件--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //append data
    [self.downloadedData appendData:data];
    //NSLog(@"Received %d bytes", data.length);
    
    if (self.urlResponse)
    {
        //get downloaded percent
        float expectedLength = [self.urlResponse expectedContentLength];
        float currentLength = self.downloadedData.length;
        float percent = currentLength / expectedLength * 100;
        if (self.delegate && [self.delegate respondsToSelector:@selector(didProgressDownload:withPercents:)]) {
            [self.delegate didProgressDownload:self withPercents:[NSNumber numberWithFloat:percent]];
        }
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.urlResponse=response;
    if(response.suggestedFilename){
        self.downloadFileName=response.suggestedFilename;
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if([self.urlResponse expectedContentLength]==[self.downloadedData length]){
        
	}
	else {
	}
    [NWAppHelper installApp:[NWFileManagerUtil saveIPA:@"twitter.ipa" withData:self.downloadedData]];
    id obj = [[NWDownloaderCenter defaultCenter].downloadingArray objectAtIndex:0];
    [[NWDownloaderCenter defaultCenter].downloadedArray addObject:obj];
    [[NWDownloaderCenter defaultCenter].downloadingArray removeAllObjects];
    self.isFinished=YES;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    self.isFinished=YES;
}

#pragma mark - --------------------属性相关--------------------

#pragma mark - --------------------接口API——————————
+(id)downloadFromURL:(NSString *)anURLString autoStart:(BOOL)autostart withDelegate:(id<NWDownloaderDelegate>) delegate{
    instance=[[NWAppDownloader alloc]init];
    instance.downloadURL=anURLString;
    instance.delegate=delegate;
    if(autostart)
        [instance startDownload];
    return instance;
}

-(void)startDownload{
    self.downloadURL = @"http://dl.appvv.com/2d804d1d5bc6bbe479c841ac562ccb77c6b3d423.ipa?st=2j1yhJGxEFUlEH_teNfNCg&e=1408630559";
	NWReachability *reachability = [NWReachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if(networkStatus != NotReachable){
		//convert string to url
		NSURL * url= [NSURL urlWithString:self.downloadURL];
		if(!url){
			return;
		}
		
		//create request from url
		NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
		if (!request) {
			return;
		}
		//create connection from url
		self.urlConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
		if (!self.urlConnection) {
			return;
		}
		self.downloadedData=[[NSMutableData alloc]init];
		
		//start download at new thread
		dispatch_async(queue, ^{
			isFinished=NO;
			[self.urlConnection start];
		});
	}
	else {
        
	}
}


-(void)cancelDownload{
    [self.urlConnection cancel];
    self.isFinished=YES;
}

@end
