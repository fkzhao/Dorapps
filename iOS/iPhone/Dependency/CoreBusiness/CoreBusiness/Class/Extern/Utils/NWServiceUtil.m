//
//  NWServiceUtil.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWServiceUtil.h"

@implementation NWServiceUtil
+(NWServiceStatusModel *) fetchServiceStatusModel:(NSString *)token
{
    NWServiceResultBlock *block = [[NWRequestQueue ShareQueue] getServiceReslutBlock:token];
    NWServiceStatusModel *mainServiceModel = [block getServiceResultModel];
    return mainServiceModel;
}

+(void)cancelServiceWith:(NSString *)token
{
    [[NWRequestQueue ShareQueue] removeNetWorkRequestWithToken:token];
}
@end
