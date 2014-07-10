//
//  CTSenderCallBack.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSenderCallBack.h"

@implementation CTSenderCallBack

@synthesize senderSuccess;
@synthesize senderFail;

-(id)init {
    self = [super init];
    if (self) {
        self.senderSuccess = nil;
        self.senderFail =  nil;
    }
    return self;
}

@end
