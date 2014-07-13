//
//  NWButtonItem.m
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWButtonItem.h"

@implementation NWButtonItem
@synthesize label;
@synthesize action;

+(id)item
{
    return [self new];
}

+(id)itemWithLabel:(NSString *)inLabel
{
    NWButtonItem *newItem = [self item];
    [newItem setLabel:inLabel];
    return newItem;
}

+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action
{
    NWButtonItem *newItem = [self itemWithLabel:inLabel];
    [newItem setAction:action];
    return newItem;
}

@end
