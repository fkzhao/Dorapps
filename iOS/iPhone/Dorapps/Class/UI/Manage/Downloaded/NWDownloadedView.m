//
//  NWDownloadedView.m
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadedView.h"
#import "NWTableView.h"
#import "NWDownloadedCell.h"
@interface NWDownloadedView ()<NWTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSources;
}

@property (nonatomic,strong)NWTableView *mainTableView;


@end

@implementation NWDownloadedView

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
        [self addSubview:_mainTableView];
    }
}

-(void)initData
{
    _dataSources = [[NSMutableArray alloc]initWithCapacity:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSources.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NWDownloadedCell *cell = (NWDownloadedCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWDownloadedCell class])];
    if (cell == nil) {
        cell = (NWDownloadedCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWDownloadedCell class]) atIndex:0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)pullDownToRefreshData:(NWTableView *)tableView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadDataWithRefreshingIsAllLoaded:NO];
        });
    });
}
@end
