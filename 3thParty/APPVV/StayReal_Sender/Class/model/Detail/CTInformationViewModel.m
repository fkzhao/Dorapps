//
//  CTInformationViewModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTInformationViewModel.h"

@implementation CTInformationViewModel
@synthesize info;
@synthesize washing;
@synthesize other;

-(id)init
{
    self = [super init];
    if (self) {
        self.info = @"";
        self.washing = @"";
        self.other = @"";
    }
    return self;
}

@end
