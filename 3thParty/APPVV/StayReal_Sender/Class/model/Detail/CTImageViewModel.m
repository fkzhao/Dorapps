//
//  CTImageViewModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-11.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTImageViewModel.h"

@implementation CTImageViewModel
@synthesize imageID;
@synthesize imageDescription;
@synthesize imageURL_F;
@synthesize imageURL_L;
@synthesize imageURL_M;
@synthesize imageURL_S;

-(id)init
{
    self = [super init];
    if (self) {
        self.imageID = @"";
        self.imageDescription = @"";
        self.imageURL_S = @"";
        self.imageURL_M = @"";
        self.imageURL_L = @"";
        self.imageURL_F = @"";
    }
    return self;
}
-(void)fullOutModel:(NSDictionary *)imageDic
{
    self.imageID = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"ID"]]];
    self.imageDescription = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"description"]]];
    self.imageURL_S = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"image_S"]]];
    self.imageURL_M = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"image_M"]]];
    self.imageURL_L = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"image_L"]]];
    self.imageURL_F = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"image_F"]]];

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
