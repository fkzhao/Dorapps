//
//  CTRelateProductModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 产品资讯相关产品**/
@interface CTRelateProductModel : NSObject

/* 产品ID**/
@property (copy,nonatomic) NSString *productID;
/* 产品名称**/
@property (copy,nonatomic) NSString *productName;
/* 产品价格**/
@property (copy,nonatomic) NSString *imageURL;

-(void)fullOutModel:(NSDictionary *)relateDic;
@end
