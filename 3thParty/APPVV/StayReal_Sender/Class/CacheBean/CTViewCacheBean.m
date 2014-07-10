//
//  CTCacheBean.m
//  StayReal_Sender
//
//  Created by Ansel on 13-7-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTViewCacheBean.h"

@implementation CTViewCacheBean

-(id)init{
    self = [super init];
    if (self) {
        
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
    //让子类实现
}

/**
 组装CacheBean
 
 @param	dic	字典类型
 
 @retrun 不需要返回值
 */
-(void)assemblyViewCacheBean:(NSDictionary *)dic{
    //让子类实现
}
/**
 清除cacheBean
 
 @prama 不需要参数
 
 @prama 没有返回值
 */
-(void)clean
{
    //让子类实现
}
/**
 每一个cache之间传值用的
 
 @param	tag	Save的标识符
 
 @return 不需要返回值
 */
-(void)save:(NSString *)tag
{
    //让子类实现
}

-(NSString *)stringEmptyOrNil:(NSString *)string
{
    if (string.length == 0 || !string) {
        return @"";
    } else {
        return string;
    }
}
@end
