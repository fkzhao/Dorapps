//
//  NWButtonItem.h
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWButtonItem : NSObject
{
    NSString *label;
    void (^action)();
}

@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) void (^action)();
+(id)item;
+(id)itemWithLabel:(NSString *)inLabel;
+(id)itemWithLabel:(NSString *)inLabel action:(void(^)(void))action;
@end
