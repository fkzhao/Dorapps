//
//  NWViewCacheBeanBlock.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWViewCacheBeanBlock.h"

@implementation NWViewCacheBeanBlock

@synthesize array,capacity,condition;
-(id)init
{
    self = [super init];
    if (self) {
        capacity = 0;
        id temp = [[NSCondition alloc] init];
        self.condition = temp;
        self.array = [NSMutableArray arrayWithCapacity :capacity];
    }
    return self;
}

- (id) getViewCacheBean
{
    [condition lock];
    while([self.array count] == 0) {
        [condition wait];
    }
    id retObj = [self.array objectAtIndex:0];
    [self.array removeObjectAtIndex:0];
    [condition unlock];
    return  retObj;
    
}

- (void) putViewCacheBean:(id)obj
{
    [condition lock];
    [self.array addObject:obj];
    [condition signal];
    [condition unlock];
}

@end
