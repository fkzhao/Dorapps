//
//  CTListViewModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 列表页每一个条目的Model**/
@interface CTListViewModel : NSObject

/* 
 产品ID
 **/
@property (copy,nonatomic) NSString *producID;

/* 
 限定地区
 **/
@property (strong,nonatomic) NSString *limitArea;
/*
 限定门店
 **/
@property (strong,nonatomic) NSString *limitStore;

/* 
 名称
 **/
@property (copy,nonatomic) NSString *producName;
/* 
 图片链接
 **/
@property (copy,nonatomic) NSString *producImageURL;
/* 
 是否收藏
 **/
@property (unsafe_unretained,nonatomic) BOOL isCollection;
/* 
 其它
 **/
@property (copy,nonatomic) NSString *other;
/* 
 台币
 **/
@property (copy,nonatomic) NSString *price_tw;
/* 
 港币
 **/
@property (copy,nonatomic) NSString *price_hk;
/* 
 人民币
 **/
@property (copy,nonatomic) NSString *price_cn;
/* 
 日币
 **/
@property (copy,nonatomic) NSString *price_jp;
/* 
 界面显示价格（带有货币标示符）
 **/
@property (copy,nonatomic) NSString *price;
@end
