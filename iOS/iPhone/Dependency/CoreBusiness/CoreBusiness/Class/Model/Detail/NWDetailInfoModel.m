//
//  NWDetailInfoModel.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDetailInfoModel.h"

@implementation NWDetailInfoModel


-(id)init
{
    self = [super init];
    if (self) {
        self.appIcon = @"";
        self.appRating = @"";
        self.appName = @"";
        self.appVersion = @"";
        self.appSize = @"";
        self.appReleaseNote = @"";
        self.jbDownloadURL = @"";
        self.downloadURL = @"";
    }
    return self;
}

@end
