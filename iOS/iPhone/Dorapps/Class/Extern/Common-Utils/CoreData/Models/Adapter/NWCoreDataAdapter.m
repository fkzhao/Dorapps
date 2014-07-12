//
//  NWCoreDataAdapter.m
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWCoreDataAdapter.h"
#import "NWRuntime.h"
#import "NWStringUtil.h"

@implementation NWCoreDataAdapter

+(id)adapterManagedObject:(NSManagedObject *)managedObject toCommonObjectClass:(Class)commonObjectClass
{
    id resultObjc = nil;
    if (managedObject) {
        resultObjc = [[commonObjectClass alloc]init];
        [self adapterManagedObject:managedObject toCommonObject:&resultObjc];
    }
    return resultObjc;
}

+(void)adapterManagedObject:(NSManagedObject *)managedObject toCommonObject:(NSObject **)commonObject
{
    if (managedObject) {
        NSArray *managerObjectPropertyList = [NWRuntime fetchPropertyArray:managedObject];
        NSArray *commonObjectPropertyList = [NWRuntime fetchPropertyArray:*commonObject];
        for (NSString *managedStr in managerObjectPropertyList) {
            NSString *newManagedStr = [NWStringUtil convertToLowercase:managedStr];
            for (NSString *commonStr in commonObjectPropertyList) {
                NSString *newCommondStr = [NWStringUtil convertToLowercase:commonStr];
                if ([newCommondStr isEqualToString:newManagedStr]) {
                    [*commonObject setValue:[managedObject valueForKey:managedStr] forKey:commonStr];
                }
            }
        }
    }
}

+(BOOL)checkArrayEqual:(NSArray *)firstArray otherArray:(NSArray *)secondArray
{
    if (firstArray.count != secondArray.count) {
        return NO;
    }
    for (NSString *fisrtStr in firstArray) {
        NSString *newFirstStr = [NWStringUtil convertToLowercase:fisrtStr];
        for (NSString *secondStr in secondArray) {
            NSString *newSecondStr = [NWStringUtil convertToLowercase:secondStr];
            if (![newFirstStr isEqualToString:newSecondStr]) {
                return NO;
            }
        }
    }
    return YES;
}

+(void)adapterCommonObject:(id)commonObject toManagerObject:(NSManagedObject **)managedObject
{
    if (!commonObject) {
        return;
    }
    if (!*managedObject) {
        return;
    }
    NSArray *managerObjectPropertyList = [NWRuntime fetchPropertyArray:*managedObject];
    NSArray *commonObjectPropertyList = [NWRuntime fetchPropertyArray:commonObject];
    for (NSString *managedStr in managerObjectPropertyList) {
        NSString *newManagedStr = [NWStringUtil convertToLowercase:managedStr];
        for (NSString *commonStr in commonObjectPropertyList) {
            NSString *newCommondStr = [NWStringUtil convertToLowercase:commonStr];
            if ([newCommondStr isEqualToString:newManagedStr]) {
                [*managedObject setValue:[commonObject valueForKey:commonStr] forKey:managedStr];
            }
        }
    }
}
@end
