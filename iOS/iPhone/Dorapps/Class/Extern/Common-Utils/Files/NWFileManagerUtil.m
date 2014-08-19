//
//  NWFileManagerUtil.m
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWFileManagerUtil.h"

@implementation NWFileManagerUtil


+(NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+(NSString *)getDownloaderPath
{
   
    NSString *path = [[self getDocumentPath] stringByAppendingPathComponent:@"Downloader"];
    return path;
}

+(NSString *)getDownloaderItemPath:(NSString *)token
{
    NSString *path = [self getDownloaderPath];
    path = [path stringByAppendingPathComponent:token];
    return path;
}

+(BOOL)createDownloderFolder
{
    [self createFolder:[self getDownloaderPath]];
    return YES;
}
+(BOOL)createFolder:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    NSError *error = nil;
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if (error) {
        NSLog(@"%@",error.localizedDescription);
        return NO;
    } 
    return YES;
}
+(NSString *)saveIPA:(NSString *)ipaName withData:(NSData *)data
{
    [self createDownloderFolder];
    NSString *path = [self getDownloaderPath];
    path = [path stringByAppendingPathComponent:ipaName];
    [self witreFileTo:path withData:data];
    return path;
}
+(BOOL)removeFolder:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if ( isDir == YES && existed == YES)
    {
        [fileManager removeItemAtPath:path error:&error];
    }
    if (error) {
        NSLog(@"%@",error.localizedDescription);
        return NO;
    }
    return YES;
}

+(BOOL)witreFileTo:(NSString *)path withData:(NSData *)data
{
    if (!data) {
        return NO;
    }
    [data writeToFile:path atomically:YES];
    return YES;
}

+(NSData *)readFileFrom:(NSString *)path
{
    NSData *data = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if ( isDir != YES && existed == YES)
    {
        data = [NSData dataWithContentsOfFile:path];
    }
    return data;
}

+(BOOL)hasFileOrFolder:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path];
    if (existed == YES)
    {
       return YES;
    } else {
        return NO;
    }
}

@end
