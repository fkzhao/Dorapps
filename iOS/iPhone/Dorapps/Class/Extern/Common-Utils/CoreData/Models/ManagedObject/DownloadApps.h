//
//  DownloadApps.h
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DownloadApps : NSManagedObject

@property (nonatomic, retain) NSDate * createtime;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSDate * endtime;
@property (nonatomic, retain) NSNumber * isFinished;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * isCanceled;
@property (nonatomic, retain) NSDate * finishtime;
@property (nonatomic, retain) NSNumber * totalsize;
@property (nonatomic, retain) NSNumber * downloadedsize;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * apptime;
@property (nonatomic, retain) NSString * version;
@property (nonatomic, retain) NSString * appsize;

@end
