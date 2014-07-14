//
//  NWMenuListView.m
//  Dorapps
//
//  Created by Anselz @(Janselz)on 14-7-14.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWMenuListView.h"
#import "NWTableViewCellUtil.h"

@implementation NWMenuListView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseView];
    }
    return self;
}

-(void)initBaseView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        CGRect frame = self.bounds;
        _mainTableView.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height);
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_mainTableView];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NWCategoriesTableViewCell *cell = (NWCategoriesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWCategoriesTableViewCell class])];
    if (cell == nil) {
        cell = (NWCategoriesTableViewCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWCategoriesTableViewCell class]) atIndex:0];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(selectMenuAtIndex:)]) {
        [self.menuDelegate selectMenuAtIndex:indexPath.row];
    }
}
@end
