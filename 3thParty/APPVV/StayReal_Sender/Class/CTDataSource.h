//
//  CTDataSource.h
//  StayReal_Sender
//
//  Created by Anselz on 13-11-4.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTConfig.h"
@class CTDataSource;
extern CTDataSource *__dataSource;
void initDataSource();
void freeDataSource();
@interface CTDataSource : NSObject

@property (nonatomic,assign)BOOL isShowImage;
@property (nonatomic,copy) NSString *httpURL;
@property (nonatomic,copy) NSString *region;

@end
