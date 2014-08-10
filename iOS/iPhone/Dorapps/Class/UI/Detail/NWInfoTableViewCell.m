//
//  NWInfoTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NWUIDefine.h"
#import "NWDownloadStatusBar.h"
#import "NWDownloaderCenter.h"

@interface NWInfoTableViewCell ()
{
    NWDetailInfoModel *_model;
}
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *appRating;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *appVersion;
@property (weak, nonatomic) IBOutlet UILabel *appSize;
@property (weak, nonatomic) IBOutlet UILabel *appReleaseNote;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

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
    [NWDownloadStatusBar showStatusBar:[NSString stringWithFormat:@"%@ Add to Downloading...",_model.appName]];
    [NWDownloaderCenter addDownloadTask:_model.jbDownloadURL withDelegate:nil];
}
+(CGFloat)heightForCell:(NWDetailInfoModel *)model
{
    CGFloat height = 80.0f;
    CGSize newSize;
    if (isIos7) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
        newSize = [model.appReleaseNote boundingRectWithSize:CGSizeMake(205, 9999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    } else {
        newSize = [model.appReleaseNote sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(205, 9999)];
    }
    if (newSize.height > 40) {
        height = height + newSize.height;
    } else {
        height = height + 40;
    }
    height = height + 30;
    return height;
}

-(void)displayCellWith:(NWDetailInfoModel *)model
{
    _model = model;
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
    CGRect frame = self.appReleaseNote.frame;
    CGSize newSize;
    if (isIos7) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
        newSize = [model.appReleaseNote boundingRectWithSize:CGSizeMake(205, 9999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    } else {
        newSize = [model.appReleaseNote sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(205, 9999)];
    }
    frame.size = newSize;
    CGRect downloadBtnFrame = self.downloadBtn.frame;
    downloadBtnFrame.origin.y = 120;
    if (frame.size.height > 40) {
        self.appReleaseNote.frame = frame;
        downloadBtnFrame.origin.y = downloadBtnFrame.origin.y + (frame.size.height - 40);
    }
    self.downloadBtn.frame = downloadBtnFrame;
    self.appReleaseNote.text = model.appReleaseNote;
    
}
@end
