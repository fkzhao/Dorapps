//
//  NWToolBarView.h
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NWToolBarViewDelegate <NSObject>

-(void)selectItemAtIndex:(NSInteger)index;

@end

@interface NWToolBarView : UIView

@property (nonatomic,assign) id<NWToolBarViewDelegate>delegate;
@property (nonatomic, strong) UIColor *blurTintColor;

-(void)setSelectItem:(NSInteger)index;
@end
