//
//  CTImageViewModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 页面显示图片model**/
@interface CTImageViewModel : NSObject

/* 大图ID**/
@property (copy,nonatomic) NSString *imageID;
/* 大图描述**/
@property (copy,nonatomic) NSString *imageDescription;
/* 小图URL**/
@property (copy,nonatomic) NSString *imageURL_S;
/* 中图URL**/
@property (copy,nonatomic) NSString *imageURL_M;
/* 大图URL**/
@property (copy,nonatomic) NSString *imageURL_L;
/* 原图URL**/
@property (copy,nonatomic) NSString *imageURL_F;

-(void)fullOutModel:(NSDictionary *)imageDic;
@end
