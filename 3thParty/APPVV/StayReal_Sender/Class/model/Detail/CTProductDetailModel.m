//
//  CTProductDetailModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTProductDetailModel.h"

@implementation CTProductDetailModel
@synthesize productName;
//@synthesize stenciModel;
//@synthesize selectStencil;
-(id)init
{
    self = [super init];
    if (self) {
        self.productName = @"";
//        self.stenciModel = [[CTProductStencilModel alloc]init];
//        self.selectStencil = [[CTProductStencilModel alloc]init];
    }
    return self;
}
@end
