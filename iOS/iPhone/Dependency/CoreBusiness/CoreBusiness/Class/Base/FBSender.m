//
//  FBSender.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-6-27.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "FBSender.h"
#import "NWTokenUtil.h"

@implementation FBSender


-(NWServiceResultModel *) createSenderResult:(NSString *)className methodName:(NSString *)methodName{
    NWServiceResultModel * model = [[NWServiceResultModel alloc] init];
    NSString * tokenStr = [[NSString alloc] initWithFormat:@"%@.%@",className,methodName];
    model.resultToke = [NWTokenUtil createServiceToken:tokenStr];
    return model;
}

@end
