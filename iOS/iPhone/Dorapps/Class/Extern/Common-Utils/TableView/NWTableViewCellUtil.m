//
//  NWTableViewCellUtil.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWTableViewCellUtil.h"

@implementation NWTableViewCellUtil

+(instancetype)loadCell:(NSString *)nibName atIndex:(NSInteger)index {
    if (nibName.length <=0) {
        return nil;
    }
    id cellObj = nil;
    NSArray *cellArray = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil];
    if (cellArray.count > index) {
        cellObj = [cellArray objectAtIndex:index];
    }
    return cellObj;
}
@end
