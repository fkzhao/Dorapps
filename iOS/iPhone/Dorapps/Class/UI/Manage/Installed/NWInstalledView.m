//
//  NWInstalledView.m
//  APPVV
//
//  Created by Anselz on 14-7-8.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWInstalledView.h"
#import "NWTableView.h"
#import "NWInstalledCell.h"
#import "NWHasApp.h"
#include <dlfcn.h>

extern NSString *SBSCopyLocalizedApplicationNameForDisplayIdentifier(NSString *identifier);
static NSData * (*SBSCopyIconImagePNGDataForDisplayIdentifier)(NSString *identifier) = NULL;

@interface NWInstalledView ()<NWTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSources;
}

@property (nonatomic,strong)NWTableView *mainTableView;

@end

@implementation NWInstalledView

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

-(void)initData
{
    _dataSources = [[NSMutableArray alloc]initWithCapacity:0];
    
    SBSCopyIconImagePNGDataForDisplayIdentifier = dlsym(RTLD_DEFAULT, "SBSCopyIconImagePNGDataForDisplayIdentifier");
    setgid(0);
    setuid(0);
    

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
    NWInstalledCell *cell = (NWInstalledCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWInstalledCell class])];
    if (cell == nil) {
        cell = (NWInstalledCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWInstalledCell class]) atIndex:0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    for (NSString *path in [fileManager contentsOfDirectoryAtPath:@"/var/mobile/Applications" error:nil]) {
        for (NSString *subpath in [fileManager contentsOfDirectoryAtPath:
                                   [NSString stringWithFormat:@"/var/mobile/Applications/%@", path] error:nil]) {
            if ([subpath hasSuffix:@".app"])
            {
                NSString* infoplist = [NSString stringWithFormat:@"/var/mobile/Applications/%@/%@/Info.plist", path, subpath];
                NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:infoplist];
                NSString* bundleid = [dict objectForKey:@"CFBundleIdentifier"];
                if ([bundleid isEqualToString:@"com.appvv.vCrackr"])
                    continue;
                NSString* excutable = [dict objectForKey:@"CFBundleExecutable"];
                NSMutableArray* appDetail = [[NSMutableArray alloc] init];
                [appDetail addObject:bundleid];
                [appDetail addObject:[NSString stringWithFormat:@"/var/mobile/Applications/%@/%@/", path, subpath]];
                [appDetail addObject:[NSString stringWithFormat:@"%@", excutable]];
                appDetail=nil;
            }
        }
    }

}

- (void)pullDownToRefreshData:(NWTableView *)tableView
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainTableView reloadDataWithIsAllLoaded:YES];
        });
    });
}


- (void)detectApps{
    [NWHasApp detectAppDictionariesWithIncremental:^(NSArray *appDictionaries) {
        NSMutableArray *newAppDictionaries = [NSMutableArray arrayWithArray:nil];
        [newAppDictionaries addObjectsFromArray:appDictionaries];
            } withSuccess:^(NSArray *appDictionaries) {
        [self.mainTableView reloadData];
    } withFailure:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alertView show];
        [self.mainTableView reloadData];
    }];
    [self.mainTableView reloadData];
}

@end
