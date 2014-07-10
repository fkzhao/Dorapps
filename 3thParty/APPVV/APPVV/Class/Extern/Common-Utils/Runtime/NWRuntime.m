//
//  NWRuntime.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWRuntime.h"
#import <objc/runtime.h>
#import "NWNavigationBar.h"

void exchangeSelector(Class c, SEL originalSEL, SEL newSEL)
{
    Method originalMethod = class_getInstanceMethod(c, originalSEL);
    Method newMethod = class_getInstanceMethod(c, newSEL);
    
    if(class_addMethod(c, originalSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, newSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    else
        method_exchangeImplementations(originalMethod, newMethod);
}

void replaceMethod() {

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        exchangeSelector([NWNavigationBar class], @selector(drawRect:),@selector(customDrawRect:));
    }

}
@implementation NWRuntime
+ (void)replaceMethods {
    replaceMethod();
}
@end
