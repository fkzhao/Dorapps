//
//  CTProductDetailSender.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSender.h"
#import "CTDataSource.h"

@interface CTProductDetailSender : CTSender
/**
 获取相关产品详情
 
 @param	productID	产品ID
 
 @return	返回一个CTSenderResultModel实例
 */
-(CTSenderResultModel *)sendGetAboutProductDetail:(NSString *)productID;
@end
