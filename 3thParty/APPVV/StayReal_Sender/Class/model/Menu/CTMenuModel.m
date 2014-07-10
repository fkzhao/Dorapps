//
//  CTMenuModel.m
//  StayReal_Sender
//
//  Created by Anselz on 13-10-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTMenuModel.h"

@implementation CTMenuModel
@synthesize categoryID;
@synthesize categoryName;

-(id)init
{
    self = [super init];
    if (self) {
        self.categoryID = @"";
        self.categoryName = @"";
        self.keyWords = [[NSMutableArray alloc]initWithCapacity:0];
        self.subCategoryArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.categoryID = [aDecoder decodeObjectForKey:@"categoryID"];
        self.categoryName = [aDecoder decodeObjectForKey:@"categoryName"];
        self.keyWords = [aDecoder decodeObjectForKey:@"keyWords"];
        self.subCategoryArray = [aDecoder decodeObjectForKey:@"subCategoryArray"];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.categoryID forKey:@"categoryID"];
    [aCoder encodeObject:self.categoryName forKey:@"categoryName"];
    [aCoder encodeObject:self.keyWords forKey:@"keyWords"];
    [aCoder encodeObject:self.subCategoryArray forKey:@"subCategoryArray"];
}

@end
