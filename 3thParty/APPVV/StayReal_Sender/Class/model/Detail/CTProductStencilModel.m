//
//  CTProductStencilModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-10-19.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTProductStencilModel.h"
#import "CTColorModel.h"

@implementation CTProductStencilModel
@synthesize stencilID;
@synthesize stencilName;
@synthesize colorArray;
@synthesize taobaoURL;
@synthesize price_cn;
@synthesize price_hk;
@synthesize price_jp;
@synthesize price_tw;
@synthesize selectColor;
-(id)init
{
    self = [super init];
    if (self) {
        self.stencilName = @"";
        self.stencilID = @"";
        self.colorArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.taobaoURL = @"";
        self.price_cn = @"";
        self.price_hk = @"";
        self.price_jp = @"";
        self.price_tw = @"";
        self.selectColor = [[CTColorModel alloc]init];
    }
    return self;
}
-(void)fullOutModel:(NSDictionary *)stencilDic
{
    self.stencilID = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[stencilDic objectForKey:@"stencil_id"]]];
    self.stencilName = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[stencilDic objectForKey:@"stencil_name"]]];
    self.price_cn = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[stencilDic objectForKey:@"price_cn"]]];
    self.price_hk = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[stencilDic objectForKey:@"price_hk"]]];
    self.price_jp = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[stencilDic objectForKey:@"price_jp"]]];
    self.price_tw = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[stencilDic objectForKey:@"price_tw"]]];
    //版型颜色
    for (id color in [stencilDic objectForKey:@"colors"]) {
        NSDictionary *colorDic = (NSDictionary *)color;
        CTColorModel *colorModel = [[CTColorModel alloc]init];
        [colorModel fullOutModel:colorDic];
        [self.colorArray addObject:colorModel];
    }
    if (self.colorArray.count > 0) {
        self.selectColor = (CTColorModel *)[self.colorArray objectAtIndex:0];
    }

}
-(NSString *)stringEmptyOrNil:(NSString *)string
{
    if (string.length == 0) {
        return @"";
    } else {
        return string;
    }
}
@end
