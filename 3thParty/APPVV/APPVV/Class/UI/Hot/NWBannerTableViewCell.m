//
//  NWBannerTableViewCell.m
//  APPVV
//
//  Created by Anselz on 14-7-6.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWBannerTableViewCell.h"
#import "NWBannerView.h"

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
-(void)showBannerView
{
    [self.bannerView setImageURLs:@[@"http://farm6.staticflickr.com/5472/9527499767_89ef3f56cd_b.jpg",@"http://image.baidu.com/i?ct=503316480&z=&tn=baiduimagedetail&ipn=d&word=BANNER%20320%2A150&step_word=&ie=utf-8&in=12599&cl=2&lm=-1&st=-1&cs=339360280,2562225399&os=1417771520,1157670971&pn=19&rn=1&di=24902689251&ln=1506&fr=&&fmq=1404576968336_R&ic=0&s=&se=1&sme=0&tab=&width=&height=&face=0&is=&istype=2&ist=&jit=&objurl=http%3A%2F%2Fimg.chinaqualitydigital.com%2Fpic%2Fz1cb7fdd-300x300-1%2Fpvcflexbanner.jpg",@"http://img1.imgtn.bdimg.com/it/u=2125047251,2941376556&fm=21&gp=0.jpg"]];

}
@end
