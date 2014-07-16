//
//  NWDownloadStatusBar.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-7-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWDownloadStatusBar : NSObject
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, weak) NSTimer *timer;
+(void)showStatusBar:(NSString *)title;
-(void)start:(NSString *)title;
@end
