//
//  NWBannerTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-7-6.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWBannerTableViewCell.h"
#import "NWBannerView.h"
#import "NWBannerModel.h"

@interface NWBannerTableViewCell ()

@property (weak, nonatomic) IBOutlet NWBannerView *bannerView;
@end
@implementation NWBannerTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [self initBaseView];
}

-(void)initBaseView
{
    self.bannerView.frame = self.contentView.bounds;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)showBannerView:(NSArray *)array withClickBlock:(void (^) (NSInteger selectIndex))clickblock
{
    NSMutableArray *imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (NWBannerModel *model in array) {
        [imageArray addObject:model.url];
    }
    [self.bannerView setImageURLs:imageArray withClickBlock:^(NSInteger selectIndex) {
        clickblock(selectIndex);
    }];
}
@end
