//
//  FBSender.h
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-6-27.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBServiceResultModel.h"
#import "FBServiceCallBack.h"
#import "NWRequestQueue.h"
#import "NWDateUtil.h"

@interface FBSender : NSObject

-(FBServiceResultModel *) createSenderResult:(NSString *)className methodName:(NSString *)methodName;

@end
