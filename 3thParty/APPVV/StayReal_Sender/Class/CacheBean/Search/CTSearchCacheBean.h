//
//  CTSearchCacheBean.h
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTViewCacheBean.h"
#import "CTSearchItemModel.h"
/* 搜索页面cache**/
@interface CTSearchCacheBean : CTViewCacheBean

/* 搜索结果List**/
@property (strong,nonatomic) NSMutableArray *itemList;
/* 其它**/
@property (strong,nonatomic) NSString *other;
@end
