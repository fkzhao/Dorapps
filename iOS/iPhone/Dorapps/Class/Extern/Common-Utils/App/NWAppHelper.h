//
//  NWAppHelper.h
//  Dorapps
//
//  Created by Anselz on 14-8-9.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dlfcn.h"
typedef int (*MobileInstallationInstall)(NSString *path, NSDictionary *dict, void *na, NSString *path2_equal_path_maybe_no_use);

@interface NWAppHelper : NSObject

+(void)installApp:(NSString *)path;

@end
