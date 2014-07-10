//
//  CTColorModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTImageViewModel.h"

/* 颜色model**/
@interface CTColorModel : NSObject
/* 颜色ID**/
@property (copy,nonatomic) NSString *colorID;
/* 颜色名字**/
@property (copy,nonatomic) NSString *colorName;
/* 颜色简称**/
@property (copy,nonatomic) NSString *colorNickName;
/* 颜色对应的图片链接**/
@property (copy,nonatomic) NSString *colorImageURL;
/* 淘宝购买链接**/
@property (copy,nonatomic) NSString *taobaoURL;
/* 雅虎购买链接**/
@property (copy,nonatomic) NSString *yahooURL;
/* 产品颜色图片**/
@property (strong,nonatomic) NSMutableArray *productImageArray;

-(void)fullOutModel:(NSDictionary *)colorDic;
@end
