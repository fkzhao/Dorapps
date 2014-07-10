//
//  CTBootSender.h
//  StayReal_Sender
//
//  Created by Anselz on 13-10-29.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSender.h"
#import "CTMenuCacheBean.h"

@interface CTBootSender : CTSender
/**
 获取相关产品详情
 
 @param	deviceToken	设备ID
 @param	systemVersion	设备系统版本
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendRegistDeviceToken:(NSString *)deviceToken
                                systemVersion:(NSString *)systemVersion
                                   systemName:(NSString *)systemName
                                         UUID:(NSString *)uuid;

/**
 获取产品分类里列表
 
 @param	cacheBean 需要填充的cacheBean
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetCategoryList:(CTMenuCacheBean *)cacheBean;
@end
