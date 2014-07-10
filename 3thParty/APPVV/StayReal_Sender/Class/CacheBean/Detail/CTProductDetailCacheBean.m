//
//  CTProductDetailCacheBean.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-8.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTProductDetailCacheBean.h"

@implementation CTProductDetailCacheBean
@synthesize productName;
@synthesize productID;
@synthesize stencilArray;
@synthesize detailModel;
@synthesize introductModel;
@synthesize otherInfoModel;
@synthesize infoModel;
@synthesize relateProduct;
@synthesize selectStencil;

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
    self.productName = @"";
    self.productTime = @"2014-03-02";
    self.productID = @"";
    self.limitArea = @"";
    self.limitStore = @"";
    self.stencilArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.detailModel = [[CTProductDetailModel alloc]init];
    self.introductModel = [[CTProductIntroductViewModel alloc]init];
    self.otherInfoModel = [[CTOtherInfoViewModel alloc]init];
    self.infoModel = [[CTInformationViewModel alloc]init];
    self.relateProduct = [[NSMutableArray alloc]initWithCapacity:0];
    self.selectStencil = [[CTProductStencilModel alloc]init];
}

/**
 组装CacheBean
 
 @param	dic	字典类型
 
 @retrun 不需要返回值
 */
-(void)assemblyViewCacheBean:(NSDictionary *)dic{
    [self.stencilArray removeAllObjects];
    [self.relateProduct removeAllObjects];
    NSInteger status = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] integerValue];
    if (status == 1) {
        NSDictionary *product = (NSDictionary *)[dic objectForKey:@"result"];
        //产品ID
        self.productID = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"product_code"]]];
        //产品名字
        self.productName = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"product_name"]]];
        //产品名字
        self.productTime = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"product_time"]]];
        
        self.limitArea = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"status_area"]]];
        self.limitStore = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"status_store"]]];
        //产品版型
        for (id stencil in [product objectForKey:@"product_stencil"]) {
            NSDictionary *stencilDic = (NSDictionary *)stencil;
            CTProductStencilModel *model = [[CTProductStencilModel alloc]init];
            [model fullOutModel:stencilDic];
            [self.stencilArray addObject:model];
        }
        if (self.stencilArray.count > 0) {
            self.selectStencil = (CTProductStencilModel *)[self.stencilArray objectAtIndex:0];
        }
        //产品资讯
        self.infoModel.info = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"product_info"]]];
        self.infoModel.washing = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"product_washing"]]];
        //产品简介
        self.introductModel.content = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"product_intro"]]];
        //产品材质
        self.otherInfoModel.material = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[product objectForKey:@"product_material"]]];
        //相关产品
        for (id relate in [product objectForKey:@"product_relate"]){
            NSDictionary *relateDic = (NSDictionary *)relate;
            CTRelateProductModel *model = [[CTRelateProductModel alloc]init];
            [model fullOutModel:relateDic];
            [self.relateProduct addObject:model];
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
