//
//  NWSettingViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWSettingViewController.h"

@interface NWSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation NWSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"设置"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    switch (section) {
        case 0:
            numberOfRows = 8;
            break;
        case 1:
            numberOfRows = 1;
            break;
        case 2:
            numberOfRows = 1;
            break;
        default:
            break;
    }
    return numberOfRows;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return @"如果有足够空间，保留缓存可以节省你的上网流量。";
    } else {
        return @"";
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    NSString *titleString = @"";
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                titleString = @"下载后自动安装";
                break;
            case 1:
                titleString = @"安装后自动删除安装文件";
                break;
            case 2:
                titleString = @"显示更新气泡";
                break;
            case 3:
                titleString = @"下载时禁止锁屏";
                break;
            case 4:
                titleString = @"切换到3G网络时暂停下载";
                break;
            case 5:
                titleString = @"安装成功后声音提示";
                break;
            case 6:
                titleString = @"安装成功后震动提示";
                break;
            case 7:
                titleString = @"下载后自动安装";
                break;
                
            default:
                break;
        }
    } else if(indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                titleString = @"无线分享";
                break;
            default:
                break;
        }

    } else {
        switch (indexPath.row) {
            case 0:
                titleString = @"清除图片缓存";
                break;
            default:
                break;
        }

    }
    cell.textLabel.text = titleString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
