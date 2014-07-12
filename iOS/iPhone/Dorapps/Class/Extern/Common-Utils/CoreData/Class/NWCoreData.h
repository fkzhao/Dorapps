//
//  NWCoreData.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-4.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NWLocationItem;
@class NWLocationObjectItem;

@interface NWCoreData : NSObject
- (void)saveContext;
+(instancetype)shareObject;

-(void)insertDataWith:(NSObject *)item;

-(NSArray *)fetchAllDataWith:(Class)class;
-(id)fetchDataWith:(Class)class withCondition:(NSDictionary *)condition;

-(void)deleteDataWith:(Class)class withCondition:(NSDictionary *)condition;
-(void)deleteAllDataWith:(Class)class;
-(void)deleteAllData;

-(void)updateDataWith:(NSObject *)item withCondition:(NSDictionary *)condition;
@end
