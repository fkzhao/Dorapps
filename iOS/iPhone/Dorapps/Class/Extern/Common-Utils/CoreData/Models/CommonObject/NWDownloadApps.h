//
//  NWDownloadApps.h
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWDownloadApps : NSObject
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSData * data;
@property (nonatomic, strong) NSDate * createtime;
@property (nonatomic, strong) NSDate * endtime;
@property (nonatomic, strong) NSNumber * finished;
@end
