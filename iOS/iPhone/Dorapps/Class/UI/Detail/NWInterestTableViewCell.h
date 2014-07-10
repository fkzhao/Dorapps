//
//  NWInterestTableViewCell.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NWInterestTableViewCellDelegate <NSObject>

-(void)tapAppWithIndext:(NSInteger)index;

@end
@interface NWInterestTableViewCell : UITableViewCell

@property(nonatomic,assign) id<NWInterestTableViewCellDelegate>delegate;

@end
