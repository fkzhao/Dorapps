//
//  NWStateView.h
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWTableViewDefine.h"

@interface NWStateView : UIView
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *timeLabelView;
@property (nonatomic) ePullStateType state;

-(void)changeState:(ePullStateType)state;

- (void)updateTimeLabel;
@end
