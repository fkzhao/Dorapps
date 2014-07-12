//
//  NWCoreDataAdapter.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWCoreDataAdapter : NSObject

+(id)adapterManagedObject:(NSManagedObject *)managedObject toCommonObjectClass:(Class)commonObject;

+(void)adapterManagedObject:(NSManagedObject *)managedObject toCommonObject:(NSObject **)commonObject;

+(void)adapterCommonObject:(id)commonObject toManagerObject:(NSManagedObject **)managedObject;
@end
