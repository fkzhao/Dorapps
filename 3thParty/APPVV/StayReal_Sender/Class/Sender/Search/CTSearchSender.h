//
//  CTSearchSender.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSender.h"
#import "CTSearchCacheBean.h"

@interface CTSearchSender : CTSender
/**
 获取产品列表
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(int)productID;
/**
 获取产品列表
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductDetail:(NSString *)productID;

/**
 获取产品列表
 
 @param	keyWord 关键字
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetSearchResults:(CTSearchCacheBean *)cacheBean withKeyWord:(NSString *)keyWord;
@end
