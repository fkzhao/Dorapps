//
//  FBServiceUtil.m
//  CoreBusiness
//
//  Created by Anselz on 14-6-29.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "FBServiceUtil.h"

@implementation FBServiceUtil

+(FBServiceStatusModel *) fetchServiceStatusModel:(NSString *)token
{
    NWServiceResultBlock *block = [[NWRequestQueue ShareQueue] getServiceReslutBlock:token];
    FBServiceStatusModel *mainServiceModel = [block getServiceResultModel];
    return mainServiceModel;
}

+(void)cancelServiceWith:(NSString *)token
{
    [[NWRequestQueue ShareQueue] removeNetWorkRequestWithToken:token];
}
@end
