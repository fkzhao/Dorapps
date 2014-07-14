//
//  NWMenuListView.h
//  Dorapps
//
//  Created by Anselz on 14-7-14.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NWCategoriesTableViewCell.h"

@protocol NWMenuListDelegate <NSObject>

-(void)selectMenuAtIndex:(NSInteger)selectIndex;

@end

@interface NWMenuListView : UIToolbar<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id<NWMenuListDelegate> menuDelegate;
@property (nonatomic,strong) UITableView *mainTableView;

@end
