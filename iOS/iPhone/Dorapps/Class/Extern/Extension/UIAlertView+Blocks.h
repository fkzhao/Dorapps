//
//  UIAlertView+Blocks.h
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWButtonItem.h"

@interface UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)inTitle message:(NSString *)inMessage cancelButtonItem:(NWButtonItem *)inCancelButtonItem otherButtonItems:(NWButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addButtonItem:(NWButtonItem *)item;

@end
