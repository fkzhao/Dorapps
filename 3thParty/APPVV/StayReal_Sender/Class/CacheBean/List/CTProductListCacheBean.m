//
//  CTProductListCacheBean.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-8.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTProductListCacheBean.h"

@implementation CTProductListCacheBean
@synthesize productList;
@synthesize hasMore;
@synthesize other;

-(id)init{
    self = [super init];
    if (self) {
        [self initCache];
    }
    return self;
}

/**
 初始化CacheBean
 
 @prama 不需要参数
 
 @return 不需要返回值
 */
-(void)initCache
{
    self.productList = [[NSMutableArray alloc]initWithCapacity:0];
    self.hasMore = NO;
    self.other = @"";
}

/**
 组装CacheBean
 
 @param	dic	字典类型
 
 @retrun 不需要返回值
 */
-(void)assemblyViewCacheBean:(NSDictionary *)dic{
    [self.productList removeAllObjects];
    NSInteger status = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] integerValue];
    if (status == 1) {
        NSArray *array = [dic objectForKey:@"result"];
        for (int i = 0; i< array.count;i++) {
            NSDictionary *item = (NSDictionary *)[array objectAtIndex:i];
            CTListViewModel *model = [[CTListViewModel alloc]init];
            //产品货号
            model.producID = [NSString stringWithFormat:@"%@",[item objectForKey:@"product_code"]];
            //产品名字
            model.producName = [NSString stringWithFormat:@"%@",[item objectForKey:@"product_name"]];
            model.limitArea = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[item objectForKey:@"status_area"]]];
            model.limitStore = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[item objectForKey:@"status_store"]]];

            //图片链接
            model.producImageURL = [NSString stringWithFormat:@"%@",[item objectForKey:@"product_imageurl"]];
            model.price_cn = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_cn"]];
            model.price_hk = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_hk"]];
            model.price_jp = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_jp"]];
            model.price_tw = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_tw"]];
            model.price = [NSString stringWithFormat:@"%@",[item objectForKey:@"price"]];
            [self.productList addObject:model];
        }
    }
}

/**
 清除cacheBean
 
 @prama 不需要参数
 
 @prama 没有返回值
 */
-(void)clean{
    [self initCache];
}
@end
