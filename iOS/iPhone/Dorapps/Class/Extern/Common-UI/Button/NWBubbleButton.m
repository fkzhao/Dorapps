//
//  NWBubbleButton.m
//  Dorapps
//
//  Created by Anselz on 14-7-15.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWBubbleButton.h"

@implementation NWBubbleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseView];
    }
    return self;
}

-(void)initBaseView
{
    
}

-(void)setBadgeNumber:(NSInteger)badgeNumber
{
    _badgeNumber = badgeNumber;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_badgeNumber > 0) {
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(con, CGRectMake(self.frame.size.width - 33,1,18,18));
        CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
        CGContextFillPath(con);
        
        NSString *drawStr = [NSString stringWithFormat:@"%ld",(long)_badgeNumber];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont boldSystemFontOfSize:10], NSFontAttributeName,
                                    [UIColor whiteColor], NSForegroundColorAttributeName,
                                    [UIColor clearColor], NSBackgroundColorAttributeName,
                                    nil];
        [drawStr drawInRect:CGRectMake(self.frame.size.width - 10,-1,10,10) withAttributes:attributes];
    }
}

@end
