//
//  CTRequestModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-8-10.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTRequestModel.h"

@implementation CTRequestModel

-(id)init
{
    self = [super init];
    if (self) {
        self.url = @"";
        self.HTTPMethod = eHTTPREQUEST_METHOD_GET;
        self.HTTPBody = @"";
        self.parameterDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}
/**
 组装请求参数
 
 @param 无
 
 @return 无
 
 */
-(void)assemblyParameters
{
    if (self.HTTPMethod == eHTTPREQUEST_METHOD_GET) {
        NSArray *keys;
        NSInteger i, count;
        keys = [self.parameterDic allKeys];
        count = [keys count];
        if (count > 0){
            self.url = [NSString stringWithFormat:@"%@?",self.url];
            for (i = 0; i < count; i++)
            {
                NSString* key = [NSString stringWithFormat:@"%@",[keys objectAtIndex: i]];
                NSString *value = [self.parameterDic objectForKey: key];
                self.url = [NSString stringWithFormat:@"%@%@=%@",self.url,key,value];
            }
        }

    } else {
        NSArray *keys;
        NSInteger i, count;
        keys = [self.parameterDic allKeys];
        count = [keys count];
        for (i = 0; i < count; i++)
        {
            NSString* key = [NSString stringWithFormat:@"%@",[keys objectAtIndex: i]];
            NSString *value = [self.parameterDic objectForKey: key];
            if (i == 0) {
                self.HTTPBody = [NSString stringWithFormat:@"%@=%@",key,value];
            }
            if (i >= 1) {
                self.HTTPBody = [NSString stringWithFormat:@"&%@=%@",key,value];
            }
        }
    }
}
@end
