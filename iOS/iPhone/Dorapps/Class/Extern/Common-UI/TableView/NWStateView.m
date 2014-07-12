//
//  NWStateView.m
//  Dorapps
//
//  Created by Anselz on 14-7-12.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWStateView.h"

@implementation NWStateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initView];
}

-(void)initView
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _stateLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_stateLabel];
    }
    if (!_timeLabelView) {
        _timeLabelView =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320, 15)];
        _timeLabelView.font = [UIFont systemFontOfSize:12];
        _timeLabelView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabelView];
    }
}

-(void)changeState:(ePullStateType)state
{
    
}

#pragma mark 更新时间Label
- (void)updateTimeLabel
{
    if (self.timeLabelView && !self.timeLabelView.hidden) {
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [dateFormater setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [dateFormater setDateStyle:NSDateFormatterFullStyle];
        [dateFormater setDateFormat:@"MM-dd HH:mm"];
        self.timeLabelView.text = [NSString stringWithFormat:@"更新于 %@", [dateFormater stringFromDate:date]];
    }
}

@end
