//
//  CTProductIntroductViewModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTProductIntroductViewModel.h"


@implementation CTProductIntroductViewModel
@synthesize content;
@synthesize other;

-(id)init
{
    self = [super init];
    if (self) {
        self.content = @"";
        self.other = @"";
    }
    return self;
}
@end
