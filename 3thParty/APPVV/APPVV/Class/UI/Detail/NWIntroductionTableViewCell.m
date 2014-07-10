//
//  NWIntroductionTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWIntroductionTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface NWIntroductionTableViewCell () {
    CGFloat contentSize;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *appIntroduct;

@end

@implementation NWIntroductionTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [self.mainScrollView setContentSize:CGSizeMake(0, 330)];
    contentSize = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)displayCellWith:(NWDetailIntroductModel *)model
{
    self.appIntroduct.text = model.descriptionInfo;
    if (contentSize == 0) {
        CGFloat orignX = 15;
        for (NSString *url in model.screenShots) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(orignX, 0, 190, 330)];
            [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            [self.mainScrollView addSubview:imageView];
            orignX = orignX + 190 +10;
        }
        orignX = orignX + 5;
        contentSize = orignX;
        [self.mainScrollView setContentSize:CGSizeMake(contentSize, self.mainScrollView.frame.size.height)];
    } else {
        
    }
}

@end
