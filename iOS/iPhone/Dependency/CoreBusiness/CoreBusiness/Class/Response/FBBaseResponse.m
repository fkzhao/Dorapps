//
//  FBBaseResponse.m
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-6-27.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "FBBaseResponse.h"
#import "FBServiceStatusModel.h"

@implementation FBBaseResponse

-(id)init
{
    self = [super init];
    if (self) {
        self.serviceStatusModel = [[FBServiceStatusModel alloc]init];
    }
    return self;
}


@end
