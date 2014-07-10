//
//  CTOtherInfoViewModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTOtherInfoViewModel.h"

@implementation CTOtherInfoViewModel
@synthesize material;
@synthesize other;

-(id)init
{
    self = [super init];
    if (self) {
        self.material = @"";
        self.other = @"";
    }
    return self;
}

@end
