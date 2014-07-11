//
//  NWSender.h
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWServiceResultModel.h"
#import "NWSenderResultModel.h"
#import "NWServiceCallBack.h"
#import "NWRequestQueue.h"
#import "NWDateUtil.h"
#import "NWViewCacheBeanManager.h"

@interface NWSender : NWServiceResultModel

-(NWSenderResultModel *) createSenderResult:(NSString *)className methodName:(NSString *)methodName;

@end
