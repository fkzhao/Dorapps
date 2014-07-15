//
//  NWCategoryViewController.h
//  Dorapps
//
//  Created by Anselz on 14-7-15.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWRootViewController.h"


@protocol NWCategoryViewControllerDelegate <NSObject>

-(void)selectMenuAtIndex:(NSInteger)selectIndex;

@end

@interface NWCategoryViewController : NWRootViewController

@property (nonatomic,assign) id<NWCategoryViewControllerDelegate> delegate;

@end
