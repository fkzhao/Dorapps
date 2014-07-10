//
//  NWHistoryViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWHistoryViewController.h"
#import "NWHistoryTableViewCell.h"
#import "NWDetailViewController.h"
#import "NWAppHistoryModel.h"

@interface NWHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *historyList;
}

@end

@implementation NWHistoryViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithHistory:(NSArray *)list
{
    self = [super init];
    if (self) {
        historyList = list;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"历史版本"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return historyList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NWHistoryTableViewCell *cell = (NWHistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NWHistoryTableViewCell class])];
    if (cell == nil) {
        cell = (NWHistoryTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([NWHistoryTableViewCell class]) owner:nil options:nil]objectAtIndex:0];
    }
    NWAppHistoryModel *model = (NWAppHistoryModel *)[historyList objectAtIndex:indexPath.row];
    [cell displayCellWith:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NWDetailViewController *detail = [[NWDetailViewController alloc]init];
    [self pushViewController:detail animated:YES];
}

@end
