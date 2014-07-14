//
//  NWUpdateManager.h
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWUpdateManager : NSObject
@property (nonatomic, copy) NSString *pListUrl;
@property (nonatomic, copy) NSString *versionUrl;
@property (nonatomic, copy) NSString *currentServerVersion;

+ (NWUpdateManager *)sharedManager;
- (void)checkForUpdates:(void(^)(BOOL isError,BOOL isLastVersion,BOOL isDisableAuto,NSString *statusStr))complete;
- (void)performUpdate;
@end
