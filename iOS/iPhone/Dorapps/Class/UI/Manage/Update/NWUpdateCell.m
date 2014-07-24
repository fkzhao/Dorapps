//
//  NWUpdateCell.m
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWUpdateCell.h"
#import "UIImageView+WebCache.h"
#import "NWDownloadStatusBar.h"

@interface NWUpdateCell ()
{
    NWUpdateAppModel *_model;
}

@property (weak, nonatomic) IBOutlet UIImageView *appIcon;

@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;

@end

@implementation NWUpdateCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)displayWithUpdateModel:(NWUpdateAppModel *)model
{
    _model = model;
    [self.appIcon setImageWithURL:[NSURL URLWithString:model.appIcon] placeholderImage:nil];
    self.appVersion.text = [NSString stringWithFormat:@"版本%@ | 大小%@",model.appVersion,model.appSize];
    self.appName.text = model.appName;
}
- (IBAction)downloadAction:(id)sender {
    [NWDownloadStatusBar showStatusBar:[NSString stringWithFormat:@"%@ Add to Updating...",_model.appName]];
    NSURL *url = [NSURL URLWithString:_model.appDownloadURL];
    UIApplication *thisApp = [UIApplication sharedApplication];
    [thisApp openURL:url];
}
@end
