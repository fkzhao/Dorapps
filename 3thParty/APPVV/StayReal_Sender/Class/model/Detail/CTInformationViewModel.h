//
//  CTInformationViewModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 产品资讯model**/
@interface CTInformationViewModel : NSObject

/* 产品资讯内容**/
@property (copy,nonatomic) NSString *info;
/* 产品洗涤**/
@property (copy,nonatomic) NSString *washing;
/* 产品资讯其它**/
@property (copy,nonatomic) NSString *other;
@end
