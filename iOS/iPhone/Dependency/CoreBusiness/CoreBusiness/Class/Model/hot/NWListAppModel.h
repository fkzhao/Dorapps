//
//  NWListAppModel.h
//  Dorapps
//
//  Created by Anselz (@Janselz) on 14-6-25.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWListAppModel : NSObject

@property (nonatomic,strong) NSString *downloadUrl;
@property (nonatomic,strong) NSString *appTrackName;
@property (nonatomic,strong) NSString *appIcon;
@property (nonatomic,strong) NSString *appID;
@property (nonatomic,strong) NSString *appSize;
@property (nonatomic,strong) NSString *appVersion;
@property (nonatomic,strong) NSString *appRating;
@property (nonatomic,strong) NSString *appSort;

@end
