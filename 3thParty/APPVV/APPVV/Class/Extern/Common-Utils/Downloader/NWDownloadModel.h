//
//  NWDownloadModel.h
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWDownloadModel : NSObject<NSCopying,NSCoding>

@property (nonatomic,strong) NSString *token;
@property (nonatomic,assign) NSInteger flag;
@property (nonatomic,strong) NSString *downloadUrl;
@property (nonatomic,assign) BOOL isDownloading;
@property (nonatomic,assign) BOOL isStop;
@property (nonatomic,assign) BOOL isDownloaded;
@property (nonatomic,assign) CGFloat progressValue;
@property (nonatomic,strong) NSMutableData *downloadData;
@property (nonatomic,assign) CGFloat totalSize;
@property (nonatomic,assign) CGFloat downloadedSize;

+(NSData *)archiveObjcet:(NWDownloadModel *)model;
+(NWDownloadModel *)unArchiveObject:(NSString *)dataPath;
@end
