//
//  NWDownloadApps.h
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWDownloadApps : NSObject
@property (nonatomic, strong) NSDate * createtime;
@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) NSDate * endtime;
@property (nonatomic, strong) NSNumber * isFinished;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSNumber * isCanceled;
@property (nonatomic, strong) NSDate * finishtime;
@property (nonatomic, strong) NSNumber * totalsize;
@property (nonatomic, strong) NSNumber * downloadedsize;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * apptime;
@property (nonatomic, strong) NSString * version;
@property (nonatomic, strong) NSString * appsize;
@end
