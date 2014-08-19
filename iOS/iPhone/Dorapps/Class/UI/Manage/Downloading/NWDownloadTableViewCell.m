//
//  NWDownloadTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-30.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadTableViewCell.h"
#import "NWDownloaderCenter.h"
#import "NWDownloaderDelegate.h"

@interface NWDownloadTableViewCell()<NWDownloaderDelegate>
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
-(void)startDownload:(NWDowloadModel *)model
{
    [NWDownloaderCenter addDownloadTaskWith:model withDelegate:self];
}

-(void) didProgressDownload:(NWAppDownloader *) downloaderInst withPercents:(NSNumber *) percents
{
    if (percents.floatValue == 1.0) {
        self.statusLabel.text = @"完成";
    } else {
        self.statusLabel.text = [NSString stringWithFormat:@"%.2lf%%",percents.floatValue];
    }
    [self.progressView setProgress:percents.floatValue/100];
}
@end
