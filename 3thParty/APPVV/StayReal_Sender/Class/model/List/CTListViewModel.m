//
//  CTListViewModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTListViewModel.h"

@implementation CTListViewModel
@synthesize producID;
@synthesize producName;
@synthesize producImageURL;
@synthesize isCollection;
@synthesize other;
@synthesize price_cn;
@synthesize price_hk;
@synthesize price_jp;
@synthesize price_tw;

-(id)init
{
    self = [super init];
    if (self) {
        self.producID = @"";
        self.producName = @"";
        self.limitArea = @"";
        self.limitStore = @"";
        self.producImageURL = @"";
        self.isCollection = NO;
        self.other = @"";
        self.price_cn = @"";
        self.price_hk = @"";
        self.price_jp = @"";
        self.price_tw = @"";
        self.price = @"HK 229";
    }
    return self;
}
@end
