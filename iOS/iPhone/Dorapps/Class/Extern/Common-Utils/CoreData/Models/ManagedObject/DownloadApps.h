//
//  DownloadApps.h
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DownloadApps : NSManagedObject

@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSDate * createtime;
@property (nonatomic, retain) NSDate * endtime;
@property (nonatomic, retain) NSNumber * finished;

@end
