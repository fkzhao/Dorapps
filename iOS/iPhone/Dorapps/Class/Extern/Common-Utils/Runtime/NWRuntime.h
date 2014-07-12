//
//  NWRuntime.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWRuntime : NSObject

+ (void)replaceMethods;
+(NSArray *)fetchVarArray:(id)obj;
+(NSArray *)fetchPropertyArray:(id)obj;
@end
