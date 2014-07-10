//
//  CTProductDetailCacheBean.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-8.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTViewCacheBean.h"
#import "CTImageViewModel.h"
#import "CTProductDetailModel.h"
#import "CTProductIntroductViewModel.h"
#import "CTOtherInfoViewModel.h"
#import "CTInformationViewModel.h"
#import "CTRelateProductModel.h"

/** 商品详情cache*/
@interface CTProductDetailCacheBean : CTViewCacheBean

/** 商品名字*/
@property (strong,nonatomic) NSString *productName;
/** 商品上架时间*/
@property (strong,nonatomic) NSString *productTime;
/** 限定地区*/
@property (strong,nonatomic) NSString *limitArea;
/** 限定门店*/
@property (strong,nonatomic) NSString *limitStore;
/** 商品ID*/
@property (strong,nonatomic) NSString *productID;
/** 商品图片*/
@property (strong,nonatomic) NSMutableArray *stencilArray;
/** 商品详细信息*/
@property (strong,nonatomic) CTProductDetailModel *detailModel;
/** 商品简介*/
@property (strong,nonatomic) CTProductIntroductViewModel *introductModel;
/** 商品其它信息如材质*/
@property (strong,nonatomic) CTOtherInfoViewModel *otherInfoModel;
/** 商品资讯*/
@property (strong,nonatomic) CTInformationViewModel *infoModel;
/** 商品相关产品*/
@property (strong,nonatomic) NSMutableArray *relateProduct;
/* 选择的产品版型**/
@property (strong,nonatomic) CTProductStencilModel *selectStencil;
@end
