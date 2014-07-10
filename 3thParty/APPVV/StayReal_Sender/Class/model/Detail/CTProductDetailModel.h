//
//  CTProductDetailModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTColorModel.h"
#import "CTProductStencilModel.h"
/* 页面显示图片model**/
@interface CTProductDetailModel : NSObject

/* 产品名字**/
@property (copy,nonatomic) NSString *productName;
///* 已选择版型**/
//@property (strong,nonatomic) CTProductStencilModel *selectStencil;
///* 产品版型**/
//@property (strong,nonatomic) CTProductStencilModel *stenciModel;
@end
