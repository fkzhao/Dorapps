//
//  NWUpdateView.m
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWUpdateView.h"
#import "NWUpdateCell.h"
#import "NWUpdateAppSender.h"
#import "NWUpdateViewCacheBean.h"

@interface NWUpdateView ()<NWTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSources;
}


@end

@implementation NWUpdateView

- (id)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initView];
}

-(void)initView
{
    if (!_mainTableView) {
        CGRect frame = self.bounds;
        frame.size.height = frame.size.height - 110;
        _mainTableView = [[NWTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.updateDelegate = self;
        _mainTableView.tableFooterView = nil;
        [self addSubview:_mainTableView];
    }
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    
}

-(void)initData
{
    _dataSources = [[NSMutableArray alloc]initWithCapacity:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cacheBean.appListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NWUpdateCell *cell = (NWUpdateCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWUpdateCell class])];
    if (cell == nil) {
        cell = (NWUpdateCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWUpdateCell class]) atIndex:0];
    }
    NWUpdateAppModel *model = [self.cacheBean.appListArray objectAtIndex:indexPath.row];
    [cell displayWithUpdateModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)pullDownToRefreshData:(NWTableView *)tableView
{
    if (self.updateBlock) {
        self.updateBlock();
    }
}
-(void)updateAllApps
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadDataWithIsAllLoaded:NO];
        });
    });
}
@end
