//
//  CTProductStencilModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-10-19.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTColorModel.h"

@interface CTProductStencilModel : NSObject
/* 产品版型**/
@property (copy,nonatomic) NSString *stencilID;
/* 产品版型**/
@property (copy,nonatomic) NSString *stencilName;
/* 产品颜色**/
@property (strong,nonatomic) NSMutableArray *colorArray;
/* 产品颜色**/
@property (strong,nonatomic) CTColorModel *selectColor;
/* 产品淘宝链接**/
@property (copy,nonatomic) NSString *taobaoURL;
/* 台币**/
@property (copy,nonatomic) NSString *price_tw;
/* 港币**/
@property (copy,nonatomic) NSString *price_hk;
/* 人民币**/
@property (copy,nonatomic) NSString *price_cn;
/* 日币**/
@property (copy,nonatomic) NSString *price_jp;

-(void)fullOutModel:(NSDictionary *)stencilDic;
@end
