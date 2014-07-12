//
//  NWCoreDataUtil.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-4.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NWDownloadApps.h"

@interface NWCoreDataUtil : NSObject

+(void)saveContext;

+(void)insertDownloadAppItem:(NWDownloadApps *)item;
+(void)fetchAllDownloadAppItem:(void(^)(NSArray *downloadApps))block;
+(void)fetchDownloadAppItem:(NSString *)key withValue:(NSString *)value withBlock:(void(^)(NWDownloadApps *downloadApp))block;
+(void)deleteDownloadItem:(NSString *)key withValue:(NSString *)value;
+(void)deleteDownloadAllItem;
+(void)updateDownloadItem:(NWDownloadApps *)item withKey:(NSString *)key withValue:(NSString *)value;

@end
