//
//  NWInfoTableViewCell.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWDetailInfoModel.h"

@protocol NWInfoTableViewCellDelegate <NSObject>

-(void)downloadAction:(id)sender;
-(void)showHistoryAction:(id)sender;

@end
@interface NWInfoTableViewCell : UITableViewCell

@property(nonatomic,assign) id<NWInfoTableViewCellDelegate>delegate;

-(void)displayCellWith:(NWDetailInfoModel *)model;
@end
