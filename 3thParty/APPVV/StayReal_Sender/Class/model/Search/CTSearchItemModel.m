//
//  CTSearchItemModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSearchItemModel.h"

@implementation CTSearchItemModel
@synthesize itemID;
@synthesize itemName;
@synthesize itemType;
@synthesize other;

-(id)init{
    self = [super init];
    if (self) {
        self.itemID = @"";
        self.itemName = @"";
        self.itemType = @"";
        self.other = @"";
        self.price_cn = @"";
        self.price_hk = @"";
        self.price_jp = @"";
        self.price_tw = @"";
    }
    return self;
}
@end
