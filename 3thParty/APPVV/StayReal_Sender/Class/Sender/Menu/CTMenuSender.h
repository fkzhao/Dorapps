//
//  CTMenuSender.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSender.h"
#import "CTMenuCacheBean.h"

@interface CTMenuSender : CTSender
/**
 获取产品列表
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(NSString *)categoryID;
/**
 获取产品分类里列表
 
 @param	cacheBean 需要填充的cacheBean
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetCategoryList:(CTMenuCacheBean *)cacheBean;
@end
