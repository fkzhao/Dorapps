//
//  CTAboutProductViewModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTRelateProductModel.h"

@implementation CTRelateProductModel
@synthesize productID;
@synthesize productName;
@synthesize imageURL;

-(id)init
{
    self = [super init];
    if (self) {
        self.productID = @"";
        self.productName = @"";
        self.imageURL = @"";
    }
    return self;
}
-(void)fullOutModel:(NSDictionary *)relateDic
{
    self.productID  = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[relateDic objectForKey:@"product_id"]]];
    self.productName = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[relateDic objectForKey:@"product_name"]]];
    self.imageURL = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[relateDic objectForKey:@"product_image_M"]]];
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
