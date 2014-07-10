//
//  NWDownloadModel.m
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadModel.h"

@implementation NWDownloadModel

-(id)init
{
    self = [super init];
    if (self) {
        self.token = @"";
        self.flag = 0;
        self.isDownloading = NO;
        self.isStop = NO;
        self.isDownloaded = NO;
        self.progressValue = 0.0;
        self.downloadUrl = @"";
        self.downloadData = [[NSMutableData alloc]initWithCapacity:0];
        self.totalSize = 0.0;
        self.downloadedSize = 0.0;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    NWDownloadModel *newObj = [[[self class] allocWithZone:zone] init];
    return newObj;
}


-(void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.token forKey:@"token"];
	[aCoder encodeInteger:self.flag forKey:@"flag"];
    [aCoder encodeObject:self.downloadUrl forKey:@"downloadUrl"];
    [aCoder encodeBool:self.isDownloading forKey:@"isDownloading"];
    [aCoder encodeBool:self.isDownloaded forKey:@"isDownloaded"];
    [aCoder encodeBool:self.isStop forKey:@"isStop"];
    [aCoder encodeFloat:self.progressValue forKey:@"progressValue"];
    [aCoder encodeFloat:self.totalSize forKey:@"totalSize"];
    [aCoder encodeFloat:self.downloadedSize forKey:@"downloadedSize"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
	if (self=[super init])
	{
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.flag = [aDecoder decodeIntegerForKey:@"flag"];
        self.downloadUrl = [aDecoder decodeObjectForKey:@"downloadUrl"];
        self.isDownloading = [aDecoder decodeBoolForKey:@"isDownloading"];
        self.isDownloaded = [aDecoder decodeBoolForKey:@"isDownloaded"];
        self.isStop = [aDecoder decodeBoolForKey:@"isStop"];
        self.progressValue = [aDecoder decodeFloatForKey:@"progressValue"];
        self.totalSize = [aDecoder decodeFloatForKey:@"totalSize"];
        self.downloadedSize = [aDecoder decodeFloatForKey:@"downloadedSize"];
	}
	return (self);
	
}

-(void)writeData
{
    
}

-(void)readData
{
    
}

+(NSData *)archiveObjcet:(NWDownloadModel *)model
{
    NSData	*data = [NSKeyedArchiver archivedDataWithRootObject:model];
    return data;
}

+(NWDownloadModel *)unArchiveObject:(NSString *)dataPath
{
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    NWDownloadModel *obj = nil;
    if (data) {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return obj;
}
@end
