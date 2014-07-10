//
//  NWHistoryTableViewCell.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWAppHistoryModel.h"

@interface NWHistoryTableViewCell : UITableViewCell

-(void)displayCellWith:(NWAppHistoryModel *)model;

@end
