//
//  NWDownloadingView.m
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDownloadingView.h"
#import "NWDownloadTableViewCell.h"
#import "NWTableViewCellUtil.h"
#import "NWDowloadModel.h"
#import "NWDownloaderCenter.h"

@interface NWDownloadingView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSources;
    
    NSArray *_downloadingList;
    NSArray *_watingList;
}

@property (nonatomic,strong) UITableView *mainTableView;

@end

@implementation NWDownloadingView

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
        _mainTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        [self addSubview:_mainTableView];
    }
}

-(void)initData
{
    _dataSources = [[NSMutableArray alloc]initWithCapacity:0];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    _downloadingList = [NWDownloaderCenter defaultCenter].downloadingArray;
    [self.mainTableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _downloadingList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_downloadingList.count > 0 && _watingList.count > 0) {
        return 2;
    }
    else if (_downloadingList.count > 0) {
        return 1;
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if (section == 0) {
        title = @"正在下载";
    } else {
        title = @"等待下载";
    }
    return title;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NWDownloadTableViewCell *cell = (NWDownloadTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWDownloadTableViewCell class])];
    if (cell == nil) {
        cell = (NWDownloadTableViewCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWDownloadTableViewCell class]) atIndex:0];
    }
    NWDowloadModel *model = (NWDowloadModel *)[_downloadingList objectAtIndex:indexPath.row];
    cell.appName.text = model.appName;
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.appIcon]];
    [cell startDownload:model];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
