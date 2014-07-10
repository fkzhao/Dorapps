//
//  CTMenuCacheBean.h
//  StayReal_Sender
//
//  Created by Anselz on 13-10-21.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import "CTViewCacheBean.h"
#import "CTMenuModel.h"

@interface CTMenuCacheBean : CTViewCacheBean<NSCoding>

@property (nonatomic,strong) NSMutableArray *categoryArray;

+(CTMenuCacheBean *)shareInstance;
-(void)archiveDataWithString:(NSString *)string;
+(CTMenuCacheBean *)unarchiveData;
@end
