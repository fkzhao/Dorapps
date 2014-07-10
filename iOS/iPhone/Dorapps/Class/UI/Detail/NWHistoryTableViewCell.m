//
//  NWHistoryTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHistoryTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface NWHistoryTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *appRating;

@property (weak, nonatomic) IBOutlet UILabel *appVersion;
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@end


@implementation NWHistoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)displayCellWith:(NWAppHistoryModel *)model
{
    [self.appIcon setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:nil];
    self.appVersion.text = [NSString stringWithFormat:@"版本%@",model.version];
}
@end
