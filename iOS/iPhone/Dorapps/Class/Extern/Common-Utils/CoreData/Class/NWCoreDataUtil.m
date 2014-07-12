//
//  NWCoreDataUtil.m
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-4.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWCoreDataUtil.h"
#import "NWCoreData.h"

@implementation NWCoreDataUtil

+(void)saveContext
{
    NWCoreData *coreData = [NWCoreData shareObject];
    [coreData saveContext];
}

+(void)insertDownloadAppItem:(NWDownloadApps *)item
{
    NWCoreData *coreData = [NWCoreData shareObject];
    [coreData insertDataWith:item];
}

+(NSArray *)fetchAllDownloadAppItem;
{
    NWCoreData *coreData = [NWCoreData shareObject];
    return [coreData fetchAllDataWith:[NWDownloadApps class]];
}
+(NWDownloadApps *)fetchDownloadAppItem:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
    return [coreData fetchDataWith:[NWDownloadApps class] withCondition:condition];
}

+(void)deleteDownloadItem:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
    [coreData deleteDataWith:[NWDownloadApps class] withCondition:condition];
}

+(void)deleteDownloadAllItem
{
    NWCoreData *coreData = [NWCoreData shareObject];
    [coreData deleteAllDataWith:[NWDownloadApps class]];
}

+(void)updateDownloadItem:(NWDownloadApps *)item withKey:(NSString *)key withValue:(NSString *)value
{
    NWCoreData *coreData = [NWCoreData shareObject];
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:value,key, nil];
    [coreData updateDataWith:item withCondition:condition];
}
@end
