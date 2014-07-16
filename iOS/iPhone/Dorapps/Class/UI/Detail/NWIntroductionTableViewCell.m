//
//  NWIntroductionTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWIntroductionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NWUIDefine.h"

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

+(CGFloat)heightForCell:(NWDetailIntroductModel *)model
{
    CGFloat height = 36.0f;
    CGSize newSize;
    if (isIos7) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
        newSize = [model.descriptionInfo boundingRectWithSize:CGSizeMake(290, 9999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
    } else {
        newSize = [model.descriptionInfo sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(290, 9999)];
    }
    height = height + newSize.height + 15;
    height = height + 330 + 15;
    return height;
    
}

-(void)displayCellWith:(NWDetailIntroductModel *)model
{
    if (self.appIntroduct.text.length <= 0) {
        CGRect frame = self.appIntroduct.frame;
        CGSize newSize;
        if (isIos7) {
            NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:self.appIntroduct.font,NSFontAttributeName, nil];
            newSize = [model.descriptionInfo boundingRectWithSize:CGSizeMake(290, 9999) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attribute context:nil].size;
        } else {
            newSize = [model.descriptionInfo sizeWithFont:self.appIntroduct.font constrainedToSize:CGSizeMake(frame.size.width, 9999)];
        }
        frame.size.width = newSize.width;
        frame.size.height = newSize.height;
        self.appIntroduct.frame = frame;
        self.appIntroduct.text = model.descriptionInfo;
        
        CGRect scrollViewFrame = self.mainScrollView.frame;
        scrollViewFrame.origin.y = self.appIntroduct.frame.origin.y + self.appIntroduct.frame.size.height + 10;
        self.mainScrollView.frame = scrollViewFrame;
    }
    
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
}

@end
