//
//  NWViewCacheBeanBlock.h
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWViewCacheBeanBlock : NSObject
@property(nonatomic, strong) NSMutableArray *array ;
@property(nonatomic, unsafe_unretained ) int capacity ;
@property(nonatomic, strong) NSCondition *condition ;

- (id) getViewCacheBean;
- (void) putViewCacheBean:(id)obj;
@end
