//
//  NWDownloadTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadTableViewCell.h"

@interface NWDownloadTableViewCell()
{
    
}
@end

@implementation NWDownloadTableViewCell


-(id)init
{
    self = [super init];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (IBAction)doAction:(id)sender {
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self initBaseView];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseView];
    }
    return self;
}


-(void)initBaseData
{

}

-(void)initBaseView
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    
}
@end
