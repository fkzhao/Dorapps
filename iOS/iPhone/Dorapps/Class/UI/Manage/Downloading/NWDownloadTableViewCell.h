//
//  NWDownloadTableViewCell.h
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWDowloadModel.h"
#import "NWCircularProgressButton.h"

@interface NWDownloadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet NWCircularProgressButton *progressButton;

-(void)startDownload:(NWDowloadModel *)model;
@end
