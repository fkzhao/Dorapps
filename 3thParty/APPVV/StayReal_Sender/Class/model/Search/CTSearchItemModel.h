//
//  CTSearchItemModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 查询页面所用的model**/
@interface CTSearchItemModel : NSObject

/* ID**/
@property (copy,nonatomic)NSString *itemID;
/* 图片链接**/
@property (copy,nonatomic)NSString *itemImageURL;
/* 名称**/
@property (copy,nonatomic)NSString *itemName;
/* 类型**/
@property (copy,nonatomic)NSString *itemType;
/* 其它**/
@property (copy,nonatomic)NSString *other;
/* 台币**/
@property (copy,nonatomic) NSString *price_tw;
/* 港币**/
@property (copy,nonatomic) NSString *price_hk;
/* 人民币**/
@property (copy,nonatomic) NSString *price_cn;
/* 日币**/
@property (copy,nonatomic) NSString *price_jp;
@end
