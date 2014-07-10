//
//  NWHotAppModel.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHotAppModel.h"

@implementation NWHotAppModel

-(id)init {
    self = [super init];
    if (self) {
        self.appTrackName = @"";
        self.appIcon = @"";
        self.appID = @"";
        self.appSize = @"";
        self.appVersion = @"";
        self.appRating = @"";
        self.appSort = @"";
    }
    return self;
}
@end
