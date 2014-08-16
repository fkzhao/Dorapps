//
//  NWFileManagerUtil.h
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    eFileTypeDownloadFile,
    eFileTypeOtherFile
}eFileType;

@interface NWFileManagerUtil : NSObject

+(NSString *)getDocumentPath;
+(NSString *)getDownloaderPath;
+(NSString *)getDownloaderItemPath:(NSString *)token;

+(BOOL)createFolder:(NSString *)path;
+(BOOL)removeFolder:(NSString *)path;

+(BOOL)witreFileTo:(NSString *)path withData:(NSData *)data;
+(NSData *)readFileFrom:(NSString *)path;

+(BOOL)hasFileOrFolder:(NSString *)path;
@end
