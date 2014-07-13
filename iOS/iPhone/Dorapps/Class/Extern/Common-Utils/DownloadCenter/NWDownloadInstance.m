//
//  NWDownloadInstance.m
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadInstance.h"

@implementation NWDownloadInstance

-(id)init
{
    self = [super init];
    if (self) {
        self.downloadApp = [[NWDownloadApps alloc]init];
        self.token = nil;
    }
    return self;
}

-(void)launchDonwloadTask:(NWListAppModel *)model
{
    if (model.downloadUrl.length > 0) {
        self.token = [NWDownloader addDownloader:model.downloadUrl withDelegate:self];
        self.downloadApp.token = self.token;
        self.downloadApp.icon = model.appIcon;
        self.downloadApp.version = model.appVersion;
        self.downloadApp.name = model.appTrackName;
        self.downloadApp.appsize = model.appSize;
        self.downloadApp.createtime = [NWDateUtil getCurrentDate];
    }
}

-(void)launchDonwloadTask:(NWListAppModel *)model withSize:(CGFloat)currentSize
{
    if (model.downloadUrl.length > 0) {
        self.token = [NWDownloader addDownloader:model.downloadUrl withSize:currentSize withDelegate:self];
        self.downloadApp.token = self.token;
        self.downloadApp.icon = model.appIcon;
        self.downloadApp.version = model.appVersion;
        self.downloadApp.name = model.appTrackName;
        self.downloadApp.appsize = model.appSize;
        self.downloadApp.createtime = [NWDateUtil getCurrentDate];
    }
}

#pragma mark - --------------------Download Delegate--------------------
-(void)downloadWillStart:(CGFloat)totalSize withToken:(NSString *)token
{
    
}

-(void)downloadProgress:(CGFloat)progressValue withToken:(NSString *)token
{
    
}

-(void)downloadCancel:(NSString *)token
{
    
}

-(void)downloadStopSuspend:(NSString *)token
{
    
}

-(void)downloadActivation:(NSString *)token withDownloadProgress:(CGFloat)progressValue
{
    
}

-(void)downloadFinished:(NSString *)token
{
    
}
@end
