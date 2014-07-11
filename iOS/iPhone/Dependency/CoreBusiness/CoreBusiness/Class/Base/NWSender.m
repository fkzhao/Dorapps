//
//  NWSender.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-7-11.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWSender.h"
#import "NWTokenUtil.h"

@implementation NWSender

-(NWSenderResultModel *) createSenderResult:(NSString *)className methodName:(NSString *)methodName{
    NWSenderResultModel * model = [[NWSenderResultModel alloc] init];
    NSString * tokenStr = [[NSString alloc] initWithFormat:@"%@.%@",className,methodName];
    model.resultToke = [NWTokenUtil createServiceToken:tokenStr];
    return model;
}

@end
