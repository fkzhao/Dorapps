//
//  CTServiceResultQueue.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-5.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTServiceResultQueue.h"

@implementation CTServiceResultQueue
@synthesize array,capacity,condition;
-(id)init{
    self = [super init];
    if (self) {
        capacity = 0;
        id temp = [[NSCondition alloc] init];
        self.condition = temp;
        self.array = [NSMutableArray arrayWithCapacity :capacity];
    }
    return self;
}
- (id) getResultModel{
    [condition lock];
    while([self.array count] == 0) {
        [condition wait];
    }
    id retObj = [self.array objectAtIndex:0];
    [self.array removeObjectAtIndex:0];
    [condition unlock];
    return  retObj;

}

- (void) put:(id)obj{
    [condition lock];
    [self.array addObject:obj];
    [condition signal];
    [condition unlock];
}
@end
