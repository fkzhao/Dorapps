//
//  NWDownloadInstance.h
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWListAppModel.h"
#import "NWDownloadApps.h"
#import "NWDownloader.h"
#import "NWDateUtil.h"

@interface NWDownloadInstance : NSObject<NWDownloaderDelegate>

@property (nonatomic,strong)NSString *token;
@property (nonatomic,strong)NWDownloadApps *downloadApp;

-(void)launchDonwloadTask:(NWListAppModel *)model;
-(void)launchDonwloadTask:(NWListAppModel *)model withSize:(CGFloat)currentSize;

@end
