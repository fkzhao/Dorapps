//
//  FBServiceUtil.h
//  CoreBusiness
//
//  Created by Anselz on 14-6-29.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBServiceStatusModel.h"
#import "NWServiceResultBlock.h"
#import "NWRequestQueue.h"

@interface FBServiceUtil : NSObject
+(FBServiceStatusModel *) fetchServiceStatusModel:(NSString *)token ;
+(void)cancelServiceWith:(NSString *)token;
@end
