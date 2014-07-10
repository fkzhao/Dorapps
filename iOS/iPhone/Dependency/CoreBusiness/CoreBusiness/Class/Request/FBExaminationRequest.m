//
//  FBExaminationRequest.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-6-27.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "FBExaminationRequest.h"

@implementation FBExaminationRequest

-(id)init
{
    self = [super init];
    if (self) {
        self.region = @"";
    }
    return self;
}

-(void)assemblyRequestParametersDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [dic setObject:self.region forKey:@"region"];
    
    self.parametersDic = dic;
}
@end
