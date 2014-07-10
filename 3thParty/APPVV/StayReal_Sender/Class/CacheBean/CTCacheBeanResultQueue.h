//
//  CTCacheBeanResultQueue.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCacheBeanResultQueue : NSObject

@property(nonatomic, strong) NSMutableArray *array ;
@property(nonatomic, unsafe_unretained ) int capacity ;
@property(nonatomic, strong) NSCondition *condition ;


- (id) getCacheBean;

- (void) put:(id)obj;
@end
