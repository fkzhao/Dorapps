//
//  FBExaminationSender.h
//  CoreBusiness
//
//  Created by Anselz (@Janselz) on 14-6-27.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "FBSender.h"
#import "FBServiceStatusModel.h"

@interface FBExaminationSender : FBSender

-(FBServiceResultModel *)sendGetProductList;

@end
