//
//  CTProductListSender.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTProductListCacheBean.h"
#import "CTSender.h"
/* 产品列表sender**/
@interface CTProductListSender : CTSender

/**
 	生成sender单例
    
    @prama 不需要参数
 
 	@return	返回一个CTProductListSender单例
 */
+(CTProductListSender *)getInstance;

/**
 	获取产品详情
 
 	@param	productID	产品ID
    @param  region      用户所在区域
 
 	@return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductDetail:(NSString *)productID;


/**
 获取更多产品
 
 @param	无
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetMoreProduct;

/**
 获取对应产品的产品类表
 
 @param cacheBean 页面的CacheBean
 @param	productID   产品类型
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(CTProductListCacheBean *)cacheBean withProductID:(NSString *)productID;
/**
 获取产品列表
 
 @param cacheBean 页面的CacheBean
 @param	keywords	产品分类关键字
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetProductList:(CTProductListCacheBean *)cacheBean withKeywords:(NSArray *)keywords;

/**
 获取对应产品的产品类表
 
 @param cacheBean 页面的CacheBean
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetNewProductList:(CTProductListCacheBean *)cacheBean;
@end
