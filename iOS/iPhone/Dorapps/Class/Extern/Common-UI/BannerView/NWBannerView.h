//
//  NWBannerView.h
//  APPVV
//
//  Created by Anselz on 14-7-6.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWBannerView : UIView

-(void)setImageURLs:(NSArray *)imageArray withClickBlock:(void (^) (NSInteger selectIndex))clickblock;
@end
