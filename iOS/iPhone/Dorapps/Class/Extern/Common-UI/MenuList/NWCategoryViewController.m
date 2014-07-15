//
//  NWCategoryViewController.m
//  Dorapps
//
//  Created by Anselz on 14-7-15.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWCategoryViewController.h"
#import "NWTableViewCellUtil.h"
#import "NWCategoriesTableViewCell.h"

@interface NWCategoryViewController ()

@end

@implementation NWCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"分类";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    // Do any additional setup after loading the view from its nib.
}

-(void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectMenuAtIndex:)]) {
        [self.delegate selectMenuAtIndex:indexPath.row];
    }
}

@end
