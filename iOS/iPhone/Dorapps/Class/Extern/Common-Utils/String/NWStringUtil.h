//
//  NWStringUtil.h
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LocationFlag_Title_HOT = 0,
    LocationFlag_Title_MANAGER,
    LocationFlag_Title_MORE,
    LocationFlag_Title_SEARCH,
    
    LocationFlag_UIViewController_More_Share,
    LocationFlag_UIViewController_More_Language,
    LocationFlag_UIViewController_More_Setting,
    LocationFlag_UIViewController_More_About,
    LocationFlag_UIViewController_More_Feedback,
    LocationFlag_UIViewController_More_Footer,
    
    LocationFlag_UIViewController_Manager_Downloaded,
    LocationFlag_UIViewController_Manager_Installed,
    LocationFlag_UIViewController_Manager_Downloading,
    LocationFlag_UIViewController_Manager_Update,
    
}eLocationFlag;



@interface NWStringUtil : NSObject

+(NSString *)getLocalizationString:(eLocationFlag)locationFlag;



+(NSString *)convertToLowercase:(NSString *)covertString;

+(NSString *)convertToUppercase:(NSString *)covertString;
@end
