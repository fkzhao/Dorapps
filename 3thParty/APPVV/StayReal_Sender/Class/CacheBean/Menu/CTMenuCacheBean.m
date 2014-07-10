//
//  CTMenuCacheBean.m
//  StayReal_Sender
//
//  Created by Anselz on 13-10-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTMenuCacheBean.h"
#import "SBJSON.h"

static CTMenuCacheBean *share = nil;
@implementation CTMenuCacheBean
@synthesize categoryArray;


+(CTMenuCacheBean *)shareInstance
{
    if (share == nil) {
        share = [[CTMenuCacheBean alloc]init];
    }
    return share;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self initCache];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.categoryArray = [aDecoder decodeObjectForKey:@"category"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.categoryArray forKey:@"category"];
}
-(void)archiveDataWithString:(NSString *)string
{
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"MENU_JSON"];
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}
+(CTMenuCacheBean *)unarchiveData
{
    CTMenuCacheBean *cacheBean = nil;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"category"];
    if (data == nil){
        cacheBean = [[CTMenuCacheBean alloc]init];
    } else {
        cacheBean = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return cacheBean;
}
-(void)initCache
{
    self.categoryArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"MENU_JSON"];
    if(![fileManager fileExistsAtPath:filePath])
    {
        filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"MENU_JSON"];
    }
    NSString *result = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (result.length > 0) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSDictionary *dic = [parser objectWithString:result];
        [self assemblyViewCacheBean:dic];
    }
}

-(void)assemblyViewCacheBean:(NSDictionary *)dic
{
    NSInteger status = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] integerValue];
    if (status == 1) {
        [self.categoryArray removeAllObjects];
        NSArray *category = [dic objectForKey:@"result"];
        for (int i = 0; i < category.count ; i ++) {
            NSDictionary *categoryDic = (NSDictionary *)[category objectAtIndex:i];
            CTMenuModel *model = [[CTMenuModel alloc]init];
            model.categoryID = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[categoryDic objectForKey:@"kindName"]]];
            model.categoryName = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[categoryDic objectForKey:@"kindName"]]];
            NSArray *subCategoryArr = (NSArray *)[categoryDic objectForKey:@"kinds"];
            for (int j = 0; j < subCategoryArr.count; j ++) {
                NSDictionary *subCategoryDic = (NSDictionary *)[subCategoryArr objectAtIndex:j];
                CTMenuModel *subModel = [[CTMenuModel alloc]init];
                subModel.categoryID = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[subCategoryDic objectForKey:@"categoryID"]]];
                subModel.categoryName = [self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[subCategoryDic objectForKey:@"categoryName"]]];
                [subModel.keyWords addObject:[self stringEmptyOrNil:[NSString stringWithFormat:@"%@",[subCategoryDic objectForKey:@"categoryID"]]]];
                [model.subCategoryArray addObject:subModel];
            }
            [self.categoryArray addObject:model];
        }
    }
}


@end
