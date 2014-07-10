//
//  NWInterestTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWInterestTableViewCell.h"
@interface NWInterestTableViewCell ()
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation NWInterestTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
    [self.mainScrollView setContentSize:CGSizeMake(83*5, 100)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectApp:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapAppWithIndext:)]) {
        [self.delegate tapAppWithIndext:0];
    }
}

@end
