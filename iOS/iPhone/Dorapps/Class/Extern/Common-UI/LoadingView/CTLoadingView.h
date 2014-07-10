//
//  CTLoadingView.h
//  STAYREAL
//
//  Created by Anselz on 13-8-6.
//  Copyright (c) 2013年 Ansel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RTSpinKitView;
@interface CTLoadingView : UIView

@property (strong,nonatomic) NSString *toke;

+(void)showInView:(UIView *)view withToken:(NSString *)token;
+(void)removeFromView:(UIView *)view withToken:(NSString *)token;
-(void)insertSpinner:(RTSpinKitView*)spinner
     backgroundColor:(UIColor*)backgroundColor;
@end
