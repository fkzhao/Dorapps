//
//  NWIntroductionTableViewCell.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWDetailIntroductModel.h"
@interface NWIntroductionTableViewCell : UITableViewCell

-(void)displayCellWith:(NWDetailIntroductModel *)model;

+(CGFloat)heightForCell:(NWDetailIntroductModel *)model;
@end
