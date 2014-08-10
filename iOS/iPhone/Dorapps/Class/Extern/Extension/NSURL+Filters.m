//
//  NSURL+Filters.m
//  Dorapps
//
//  Created by Anselz on 14-8-10.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NSURL+Filters.h"

@implementation NSURL (Filters)

+(id)urlWithString:(NSString *)urlString
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
//    [dic setObject:@"%20" forKey:@" "];
//    [dic setObject:@"%22" forKey:@"\""];
//    [dic setObject:@"%23" forKey:@"#"];
//    [dic setObject:@"%25" forKey:@"%"];
//    [dic setObject:@"%26" forKey:@"&"];
//    [dic setObject:@"%28" forKey:@"("];
//    [dic setObject:@"%29" forKey:@")"];
//    [dic setObject:@"%2B" forKey:@"+"];
//    [dic setObject:@"%2C" forKey:@","];
//    [dic setObject:@"%2F" forKey:@"/"];
//    [dic setObject:@"%3A" forKey:@":"];
//    [dic setObject:@"%3B" forKey:@";"];
//    [dic setObject:@"%3C" forKey:@"<"];
//    [dic setObject:@"%3D" forKey:@"="];
//    [dic setObject:@"%3E" forKey:@">"];
//    [dic setObject:@"%3F" forKey:@"?"];
//    [dic setObject:@"%40" forKey:@"@"];
//    [dic setObject:@"%5C" forKey:@"\\"];
//    [dic setObject:@"%7C" forKey:@"|"];
    
    for (NSString *key in [dic allKeys]) {
        urlString = [urlString stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"%@",[dic objectForKey:key]]];
    }
    
    return [self URLWithString:urlString];
}
@end
