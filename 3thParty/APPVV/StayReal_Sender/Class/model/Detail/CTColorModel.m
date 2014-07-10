//
//  CTColorModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTColorModel.h"

@implementation CTColorModel
@synthesize colorID;
@synthesize colorName;
@synthesize colorNickName;
@synthesize colorImageURL;
@synthesize productImageArray;
@synthesize taobaoURL;
@synthesize yahooURL;
-(id)init
{
    self = [super init];
    if (self) {
        self.colorID = @"";
        self.colorName = @"";
        self.colorNickName = @"";
        self.colorImageURL = @"";
        self.taobaoURL = @"";
        self.yahooURL = @"";
        self.productImageArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
-(void)fullOutModel:(NSDictionary *)colorDic
{
    self.colorID = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[colorDic objectForKey:@"color_ID"]]];
    self.colorName = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[colorDic objectForKey:@"color_name"]]];
    self.colorNickName = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[colorDic objectForKey:@"nick_color_name"]]];
    self.colorImageURL = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[colorDic objectForKey:@"color_image"]]];
    for (id images in [colorDic objectForKey:@"product_color_images"]) {
        NSDictionary *imageDic = (NSDictionary *)images;
        CTImageViewModel *imageModel = [[CTImageViewModel alloc] init];
        [imageModel fullOutModel:imageDic];
        [self.productImageArray addObject:imageModel];
    }
    self.taobaoURL = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[colorDic objectForKey:@"taobao"]]];
    self.yahooURL = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[colorDic objectForKey:@"yahoo"]]];
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
