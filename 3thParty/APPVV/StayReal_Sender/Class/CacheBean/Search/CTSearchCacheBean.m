//
//  CTSearchCacheBean.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-7.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTSearchCacheBean.h"
#import "CTSearchItemModel.h"
@implementation CTSearchCacheBean
@synthesize itemList;
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
    self.itemList = [[NSMutableArray alloc]initWithCapacity:0];
    self.other = @"";
}

/**
 组装CacheBean
 
 @param	dic	字典类型
 
 @retrun 不需要返回值
 */
-(void)assemblyViewCacheBean:(NSDictionary *)dic{
    [self.itemList removeAllObjects];
    NSInteger status = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] integerValue];
    if (status == 1) {
        NSArray *array = [dic objectForKey:@"result"];
        for (int i = 0; i< array.count;i++) {
            NSDictionary *item = (NSDictionary *)[array objectAtIndex:i];
            CTSearchItemModel *model = [[CTSearchItemModel alloc]init];
            model.itemID = [NSString stringWithFormat:@"%@",[item objectForKey:@"product_code"]];
            model.itemName = [NSString stringWithFormat:@"%@",[item objectForKey:@"product_name"]];
//             model.itemName = [NSString stringWithFormat:@"%@",[item objectForKey:@"category_id"]];
            model.itemImageURL = [NSString stringWithFormat:@"%@",[item objectForKey:@"product_imageurl"]];
            model.price_cn = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_cn"]];
            model.price_hk = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_hk"]];
            model.price_jp = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_jp"]];
            model.price_tw = [NSString stringWithFormat:@"%@",[item objectForKey:@"price_tw"]];
            [self.itemList addObject:model];
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
