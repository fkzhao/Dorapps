//
//  NWAppHelper.m
//  Dorapps
//
//  Created by Anselz on 14-8-9.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWAppHelper.h"
#import "dlfcn.h"

@implementation NWAppHelper

+ (int)IPAInstall:(NSString *)path
{
    void *lib = dlopen("/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation", RTLD_LAZY);
    if (lib)
    {
        MobileInstallationInstall pMobileInstallationInstall = (MobileInstallationInstall)dlsym(lib, "MobileInstallationInstall");
        if (pMobileInstallationInstall){
            int ret = pMobileInstallationInstall(path, [NSDictionary dictionaryWithObject:@"User"forKey:@"ApplicationType"], nil, path);
            dlclose(lib);
            return ret;
        }
    }
    return -1;
}

+(void)installApp:(NSString *)path
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    path = [NSString stringWithFormat:@"%@/test.ipa",docDir];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIAlertView *alert = nil;
        if ([self IPAInstall:path]!= -1) {
            alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"IPA install Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        } else {
            alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"IPA install Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
    });
}

@end
