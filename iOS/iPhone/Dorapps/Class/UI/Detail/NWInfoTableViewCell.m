//
//  NWInfoTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWInfoTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface NWInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *appRating;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;
@property (weak, nonatomic) IBOutlet UILabel *appSize;
@property (weak, nonatomic) IBOutlet UILabel *appReleaseNote;

@end
@implementation NWInfoTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)historyAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showHistoryAction:)]) {
        [self.delegate showHistoryAction:nil];
    }

}
- (IBAction)downloadAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(downloadAction:)]) {
        [self.delegate downloadAction:nil];
    }

}

-(void)displayCellWith:(NWDetailInfoModel *)model
{
    [self.appIcon setImageWithURL:[NSURL URLWithString:model.appIcon] placeholderImage:nil];
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
    
    self.appName.text = model.appName;
    self.appVersion.text = [NSString stringWithFormat:@"版本:%@",model.appVersion];
    self.appSize.text = [NSString stringWithFormat:@"大小:%@",model.appSize];
    self.appReleaseNote.text = model.appReleaseNote;
    
}
@end
