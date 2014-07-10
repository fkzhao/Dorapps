//
//  CTSenderResultModel.m
//  StayReal_Sender
//
//  Created by Ansel on 13-7-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSenderResultModel.h"

@implementation CTSenderResultModel
@synthesize resultToke;

-(id)init{
    self = [super init];
    if (self) {
        self.resultToke = @"";
    }
    return self;
}

@end
