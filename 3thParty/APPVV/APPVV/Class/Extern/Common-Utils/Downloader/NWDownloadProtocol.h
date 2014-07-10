//
//  NWDownloadProtocol.h
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NWDownloadProtocol <NSObject>

@end

@protocol NWDownloaderDelegate <NSObject>

@optional
-(void)downloadProgress:(CGFloat)progressValue withToken:(NSString *)token;

-(void)downloadCancel:(NSString *)token;

-(void)downloadStopSuspend:(NSString *)token;

-(void)downloadActivation:(NSString *)token withDownloadProgress:(CGFloat)progressValue;

-(void)downloadFinished:(NSString *)token;
@end