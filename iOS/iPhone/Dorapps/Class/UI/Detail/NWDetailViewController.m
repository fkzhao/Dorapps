//
//  NWDetailViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWDetailViewController.h"
#import "NWTableViewCellUtil.h"
#import "NWInfoTableViewCell.h"
#import "NWInterestTableViewCell.h"
#import "NWIntroductionTableViewCell.h"
#import "NWHistoryViewController.h"
#import "NWManageViewController.h"
#import "NWDetailViewCacheBean.h"
#import "NWCircleLoadingView.h"
#import "NWUIDefine.h"

@interface NWDetailViewController ()<UITableViewDelegate,UITableViewDataSource,NWInterestTableViewCellDelegate,NWInfoTableViewCellDelegate> {
    NWDetailViewCacheBean *cacheBean;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) NWCircleLoadingView *loadingView;
@end

@implementation NWDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"详情"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerLoadingView];
    
    self.loadingView = [[NWCircleLoadingView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.loadingView.lineColor = NWColorRGB(255, 255, 255);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.loadingView];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self.loadingView startAnimation];
    
    cacheBean = (NWDetailViewCacheBean *)self.viewCacheBean;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 180;
            break;
        case 1:
            return 155;
            break;
        case 2:
            return 610;
            break;
            
        default:
            return 44;
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            NWInfoTableViewCell *cell = (NWInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWInfoTableViewCell class])];
            if (cell == nil) {
                cell = (NWInfoTableViewCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWInfoTableViewCell class]) atIndex:0];
            }
            cell.delegate = self;
            [cell displayCellWith:cacheBean.appInfo];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:
        {
            NWInterestTableViewCell *cell = (NWInterestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWInterestTableViewCell class])];
            if (cell == nil) {
                cell = (NWInterestTableViewCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWInterestTableViewCell class]) atIndex:0];
            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 2:
        {
            NWIntroductionTableViewCell *cell = (NWIntroductionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWIntroductionTableViewCell class])];
            if (cell == nil) {
                cell = (NWIntroductionTableViewCell *)[NWTableViewCellUtil loadCell:NSStringFromClass([NWIntroductionTableViewCell class]) atIndex:0];
            }
            [cell displayCellWith:cacheBean.appIntroduct];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        default:
            return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            break;
    }
}

-(void)tapAppWithIndext:(NSInteger)index {
    NWDetailViewController *detail = [[NWDetailViewController alloc]init];
    [self pushViewController:detail animated:YES];
}

-(void)downloadAction:(id)sender {
    NWManageViewController *manage = [[NWManageViewController alloc]init];
    [self pushViewController:manage animated:YES];
}

-(void)showHistoryAction:(id)sender {
    NWHistoryViewController *history = [[NWHistoryViewController alloc]initWithHistory:cacheBean.historyVersionList];
    [self pushViewController:history animated:YES];
    
}

-(void)reloadView
{
    [self.loadingView stopAnimation];
    [self.mainTableView reloadData];
}
@end
