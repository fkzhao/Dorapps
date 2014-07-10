//
//  NWMoreViewController.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWMoreViewController.h"
#import "NWSettingViewController.h"
#import "NWShareViewController.h"
#import "NWLanguageViewController.h"
#import "NWAboutViewController.h"
#import "NWFeedbackViewController.h"

@interface NWMoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation NWMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = [NWStringUtil getLocalizationString:LocationFlag_Title_MORE];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return [NWStringUtil getLocalizationString:LocationFlag_UIViewController_More_Footer];
    } else {
        return @"";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString *title = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            title = [NWStringUtil getLocalizationString:LocationFlag_UIViewController_More_Share];
        } else {
            title = [NWStringUtil getLocalizationString:LocationFlag_UIViewController_More_Language];
        }
        
    } else if(indexPath.section == 1) {
        title = [NWStringUtil getLocalizationString:LocationFlag_UIViewController_More_Setting];
    } else {
        if (indexPath.row == 0) {
            title = [NWStringUtil getLocalizationString:LocationFlag_UIViewController_More_About];
        } else {
            title = [NWStringUtil getLocalizationString:LocationFlag_UIViewController_More_Feedback];
        }
    }
    cell.textLabel.text = title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NWRootViewController *next = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            next = [[NWShareViewController alloc]init];
        } else {
            next = [[NWLanguageViewController alloc]init];
        }
        
    } else if(indexPath.section == 1) {
        next = [[NWSettingViewController alloc]init];
    } else {
        if (indexPath.row == 0) {
            next = [[NWAboutViewController alloc]init];
        } else {
            next = [[NWFeedbackViewController alloc]init];
        }
    }

    
    [self pushViewController:next animated:YES];
}
@end
