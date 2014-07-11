//
//  NWServiceUtil.h
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NWServiceStatusModel.h"
#import "NWServiceResultBlock.h"
#import "NWRequestQueue.h"

@interface NWServiceUtil : NSObject
+(NWServiceStatusModel *) fetchServiceStatusModel:(NSString *)token ;
+(void)cancelServiceWith:(NSString *)token;
@end
