//
//  NWHotTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NWDownloadStatusBar.h"

@interface NWHotTableViewCell ()
{
    NWListAppModel *_model;
}
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appRating;
@property (weak, nonatomic) IBOutlet UILabel *appInfo;

@end
@implementation NWHotTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)displayCellWith:(NWListAppModel *)model {
    _model = model;
    [self.appIcon setImageWithURL:[NSURL URLWithString:model.appIcon] placeholderImage:nil];
    self.appInfo.text = [NSString stringWithFormat:@"版本%@ | 大小%@",model.appVersion,model.appSize];
    self.appName.text = model.appTrackName;
    NSInteger rating = [model.appRating integerValue];
    NSString *ratingStr = @"";
    if (rating > 0) {
        for (int i = 0; i < rating; i ++ ) {
            ratingStr = [NSString stringWithFormat:@"%@★",ratingStr];
        }
    } else {
        ratingStr = @"暂无评分";
    }
    self.appRating.text = ratingStr;
}
- (IBAction)downloadAction:(id)sender {
    [NWDownloadStatusBar showStatusBar:[NSString stringWithFormat:@"%@ Add to Downloading...",_model.appTrackName]];
}
@end
