//
//  CTProductListCacheBean.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-8.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTViewCacheBean.h"
#import "CTListViewModel.h"

/** 商品列表cache*/
@interface CTProductListCacheBean : CTViewCacheBean

/* 产品结果列表**/
@property (strong,nonatomic) NSMutableArray *productList;
/* 是否还有更多结果**/
@property (unsafe_unretained,nonatomic) BOOL hasMore;
/* 其它**/
@property (strong,nonatomic) NSString *other;
@end
