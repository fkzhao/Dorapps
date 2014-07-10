//
//  CTMenuModel.h
//  StayReal_Sender
//
//  Created by Anselz on 13-10-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTMenuModel : NSObject<NSCoding>

@property (copy,nonatomic) NSString *categoryID;
@property (copy,nonatomic) NSString *categoryName;
@property (strong,nonatomic) NSMutableArray *keyWords;
@property (strong,nonatomic) NSMutableArray *subCategoryArray;
@end
