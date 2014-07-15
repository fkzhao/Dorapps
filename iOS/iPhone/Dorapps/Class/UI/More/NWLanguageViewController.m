//
//  NWLanguageViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWLanguageViewController.h"

@interface NWLanguageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_dataSorce;
}

@end

@implementation NWLanguageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initBaseData
{
    _dataSorce = [NSArray arrayWithObjects:@"Chinese", @"English",nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Language"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSorce.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[_dataSorce objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 290, 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"更多语言见:http://dorapps.com";
    [view addSubview:label];
    return view;
}
@end
