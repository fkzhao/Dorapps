//
//  NWUpdateManager.m
//  Dorapps
//
//  Created by Anselz on 14-7-13.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWUpdateManager.h"
#import "UIAlertView+Blocks.h"
#import "NWButtonItem.h"

static NSString *const kPreferenceAskUpdate = @"pref_ask_update";
@implementation NWUpdateManager

+ (NWUpdateManager *)sharedManager {
    static NWUpdateManager *sharedManager = nil;
    if (!sharedManager)
    {
        sharedManager = [[super allocWithZone:nil] init];
    }
    return sharedManager;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedManager];
}

- (NSString *)appVersion {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [info objectForKey:@"CFBundleVersion"];
    if ([build isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%@", version];
    } else {
        return [NSString stringWithFormat:@"%@.%@", version, build];
    }
}

- (BOOL)shouldAskForUpdate {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs valueForKey:kPreferenceAskUpdate] == nil) {
        return YES;
    }
    return YES;//[prefs boolForKey:kPreferenceAskUpdate];
}

- (void)disableAskUpdate {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:kPreferenceAskUpdate];
    [prefs synchronize];
}

- (void)performUpdate {
    // in case there's a network issue or some other type of failure, we go
    // ahead and reset the preference so that the user will be prompted again
    // to update on future sessions.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:YES forKey:kPreferenceAskUpdate];
    NSURL *url = [NSURL URLWithString:_pListUrl];
    UIApplication *thisApp = [UIApplication sharedApplication];
    // turn off the badge
    [thisApp setApplicationIconBadgeNumber:0];
    // launch Mobile Safari, which will immediately attempt to install the application
    // from the URL that was specified.
    [thisApp openURL:url];
}

- (void)checkForUpdates:(void(^)(BOOL isError,BOOL isLastVersion,BOOL isDisableAuto,NSString *statusStr))complete {
    [self setPListUrl:@"itms-services://?action=download-manifest&url=https://anselz.github.io/adhoc/dorapps.plist"];
    [self setVersionUrl:@"http://anselz.github.io/dora/update.json"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:_versionUrl];
        NSError *error = nil;
        NSString *serverVersion = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            if (complete) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(YES,NO,NO,@"Fetch serverVersion ops.");
                });
            }
            return;
        }
        NSString *currentVersion = [self appVersion];
        UIApplication *thisApp = [UIApplication sharedApplication];
        if ([self compareVersion:serverVersion toVersion:currentVersion] <= 0) {
            [thisApp setApplicationIconBadgeNumber:0];
            _currentServerVersion = currentVersion;
            if (complete) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(NO,YES,NO,@"The application is up to date.");
                });
            }
            return;
        }
        [thisApp setApplicationIconBadgeNumber:1];
        _currentServerVersion = serverVersion;
        if (![self shouldAskForUpdate]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) {
                    complete(NO,NO,YES,@"There is a new version, but the user has opted to update manually later.");
                }
            });
            return;
        }
        NWButtonItem *okButton = [NWButtonItem itemWithLabel:@"OK" action:^{
            [self performUpdate];
        }];
        NWButtonItem *cancelButton = [NWButtonItem itemWithLabel:@"Cancel" action:^{
            [self disableAskUpdate];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Available"
                                                            message:@"A new version is available.  Update Now?"
                                                   cancelButtonItem:cancelButton
                                                   otherButtonItems:okButton, nil];
            [alert show];
        });
    });
}

// compares all of the bits in the version identifier starting from the left and
// returns as soon as it finds a difference.  same = 0, l > r = 1, r > l = -1
- (int)compareVersion:(NSString *)firstVersion toVersion:(NSString *)secondVersion {
    NSMutableArray *fvArray = [self splitVersionString:firstVersion];
    NSMutableArray *svArray = [self splitVersionString:secondVersion];
    
    while ([fvArray count] < [svArray count]) {
        [fvArray addObject:[NSNumber numberWithInt:0]];
    }
    while ([svArray count] < [fvArray count]) {
        [svArray addObject:[NSNumber numberWithInt:0]];
    }
    
    for (int i = 0; i < [fvArray count]; i++) {
        int a = [[fvArray objectAtIndex:i] intValue];
        int b = [[svArray objectAtIndex:i] intValue];
        
        if (a > b) {
            return 1;
        }
        
        if (b > a) {
            return -1;
        }
    }
    return 0;
}

- (NSMutableArray *)splitVersionString:(NSString *)version {
    return [NSMutableArray arrayWithArray:[version componentsSeparatedByString:@"."]];
}

@end
