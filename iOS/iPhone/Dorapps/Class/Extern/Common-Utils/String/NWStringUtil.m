//
//  NWStringUtil.m
//  APPVV
//
//  Created by Anselz (@Janselz) on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWStringUtil.h"

@implementation NWStringUtil

+(NSString *)transfromLocationFlag:(eLocationFlag)flag
{
    NSString *resultStr = @"";
    switch (flag) {
        case LocationFlag_Title_HOT:
            resultStr = @"Navigation_Title_Hot";
            break;
        case LocationFlag_Title_MANAGER:
            resultStr = @"Navigation_Title_Manager";
            break;
        case LocationFlag_Title_SEARCH:
            resultStr = @"Navigation_Title_Search";
            break;
        case LocationFlag_Title_MORE:
            resultStr = @"Navigation_Title_More";
            break;
        case LocationFlag_UIViewController_More_Share:
            resultStr = @"UIViewController_More_Share";
            break;
        case LocationFlag_UIViewController_More_Language:
            resultStr = @"UIViewController_More_Language";
            break;
        case LocationFlag_UIViewController_More_Setting:
            resultStr = @"UIViewController_More_Setting";
            break;
        case LocationFlag_UIViewController_More_Update:
            resultStr = @"UIViewController_More_Update";
            break;
        case LocationFlag_UIViewController_More_About:
            resultStr = @"UIViewController_More_About";
            break;
        case LocationFlag_UIViewController_More_Feedback:
            resultStr = @"UIViewController_More_Feedback";
            break;
        case LocationFlag_UIViewController_More_Footer:
            resultStr = @"UIViewController_More_Footer";
            break;
        case LocationFlag_UIViewController_Manager_Downloaded:
            resultStr = @"UIViewController_Manager_Downloaded";
            break;
        case LocationFlag_UIViewController_Manager_Installed:
            resultStr = @"UIViewController_Manager_Installed";
            break;
        case LocationFlag_UIViewController_Manager_Downloading:
            resultStr = @"UIViewController_Manager_Downloading";
            break;
        case LocationFlag_UIViewController_Manager_Update:
            resultStr = @"UIViewController_Manager_Update";
            break;
        default:
            break;
    }
    return resultStr;
}

+(NSString *)getLocalizationString:(eLocationFlag)locationFlag
{
    NSString *str = @"";
    str = NSLocalizedString([self transfromLocationFlag:locationFlag],nil);
    return str;
}


+(NSString *)convertToLowercase:(NSString *)covertString
{
    if (covertString.length > 0) {
        NSString *newStr = [covertString lowercaseString];
        return newStr;
    } else {
        return @"";
    }
}

+(NSString *)convertToUppercase:(NSString *)covertString
{
    if (covertString.length > 0) {
        NSString *newStr = [covertString uppercaseString];
        return newStr;
    } else {
        return @"";
    }
}

@end
