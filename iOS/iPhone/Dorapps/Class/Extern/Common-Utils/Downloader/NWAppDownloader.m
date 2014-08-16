//
//  NWAppDownloader.m
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWAppDownloader.h"
#import "NSURL+Filters.h"

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
        NSLog(@"%lf",percent);
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
	Reachability *reachability = [Reachability reachabilityForInternetConnection];
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
