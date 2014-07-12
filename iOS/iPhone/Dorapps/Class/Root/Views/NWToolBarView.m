//
//  NWToolBarView.m
//  APPVV
//
//  Created by Anselz on 14-6-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWToolBarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NWStringUtil.h"
#import "NWUIDefine.h"

#define ICON_SIZE CGRectMake(27, 4, 25, 25)

enum barsize{
    tabitem_width=80,
    tabitem_hight=44,
    tab_hight=46,
    tab_width=320,
    other_offtop=0,
    
    img_hight=38,
    img_width=25,
    img_x=27,
    img_y=4
    
};

@interface NWToolBarView () {
    NSInteger selectIndex_;
}
@property(nonatomic,strong) UIButton *shadeBtn;

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation NWToolBarView
@synthesize shadeBtn;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBaseData];
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseData];
        [self setup];
        [self initBaseView];
    }
    return self;
}

-(void)initBaseData {
    selectIndex_ = 1;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self initBaseView];
}

-(void)initBaseView {
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    bgImageView.image = [UIImage imageNamed:@"tabBar_back"];
    [self addSubview:bgImageView];
    UIImageView *imageView = nil;
    
    shadeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [shadeBtn setFrame:CGRectMake(0, other_offtop, tabitem_width, tabitem_hight+2)];
    shadeBtn.backgroundColor = [UIColor whiteColor];
    shadeBtn.userInteractionEnabled = NO;
    [shadeBtn setBackgroundImage:[UIImage imageNamed:@"toolBar_shade"] forState:UIControlStateNormal];
    [shadeBtn setBackgroundImage:[UIImage imageNamed:@"toolBar_shade"] forState:UIControlStateSelected];
    [self addSubview:shadeBtn];

    
    UIButton *firstBtn= [self createItemButton:CGRectMake(0, other_offtop, tabitem_width, tabitem_hight) withTitle:[NWStringUtil getLocalizationString:LocationFlag_Title_HOT]];
    [firstBtn setUserInteractionEnabled:NO];
    [firstBtn setSelected:YES];
    [firstBtn setTag:1];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home"] highlightedImage:[UIImage imageNamed:@"home_hight"]];
    imageView.highlighted = YES;
    imageView.tag = 1001;
    imageView.frame = ICON_SIZE;
    [firstBtn addSubview:imageView];
    
    UIButton *secondBtn=[self createItemButton:CGRectMake(tabitem_width, other_offtop, tabitem_width, tabitem_hight) withTitle:[NWStringUtil getLocalizationString:LocationFlag_Title_SEARCH]];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searching"] highlightedImage:[UIImage imageNamed:@"searching_hight"]];
    imageView.tag = 1001;
    imageView.frame = ICON_SIZE;
    [secondBtn addSubview:imageView];
    [secondBtn setTag:2];
    
    UIButton *thirdBtn=[self createItemButton:CGRectMake(tabitem_width*2, other_offtop, tabitem_width, tabitem_hight) withTitle:[NWStringUtil getLocalizationString:LocationFlag_Title_MANAGER]];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"manager"] highlightedImage:[UIImage imageNamed:@"manager_hight"]];
    imageView.tag = 1001;
    imageView.frame = ICON_SIZE;
    [thirdBtn addSubview:imageView];
    [thirdBtn setTag:3];
    
    UIButton *fourthBtn=[self createItemButton:CGRectMake(tabitem_width*3, other_offtop, tabitem_width, tabitem_hight) withTitle:[NWStringUtil getLocalizationString:LocationFlag_Title_MORE]];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"setting"] highlightedImage:[UIImage imageNamed:@"setting_hight"]];
    imageView.tag = 1001;
    imageView.frame = ICON_SIZE;
    [fourthBtn addSubview:imageView];
    [fourthBtn setTag:4];
    
    [self addSubview:firstBtn];
    [self addSubview:secondBtn];
    [self addSubview:thirdBtn];
    [self addSubview:fourthBtn];

}

-(UIButton *)createItemButton:(CGRect)frame withTitle:(NSString *)title {
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:NWColorRGB(100, 100, 100) forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleEdgeInsets = UIEdgeInsetsMake(30,0,0,0);
    return button;
}
-(void)callButtonAction:(UIButton *)sender{
    NSInteger index = sender.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectItemAtIndex:)]) {
        [self.delegate selectItemAtIndex:index];
    }
}

-(void)buttonClickAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if(selectIndex_==btn.tag) {
        return;
    } else {
        UIButton *preBtn = (UIButton *)[self viewWithTag:selectIndex_];
        [preBtn setUserInteractionEnabled:YES];
        [preBtn setSelected:NO];
        UIImageView *imageView = (UIImageView *)[preBtn viewWithTag:1001];
        imageView.highlighted = NO;
        selectIndex_=btn.tag;
    }
    
    
    [btn setSelected:YES];
    [btn setUserInteractionEnabled:NO];
    UIImageView *imageView = (UIImageView *)[btn viewWithTag:1001];
    imageView.highlighted = YES;
    [self moveShadeBtn:btn];
//    [self imgAnimate:btn];
    
    [self callButtonAction:btn];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    
    if (![self toolbar]) {
        [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
        [self.layer insertSublayer:[self.toolbar layer] atIndex:0];
    }
    [self setBlurTintColor:[UIColor whiteColor]];
}

- (void) setBlurTintColor:(UIColor *)blurTintColor {
    [self.toolbar setBarTintColor:blurTintColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}

- (void)moveShadeBtn:(UIButton*)btn{
    
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         
         CGRect frame = shadeBtn.frame;
         frame.origin.x = btn.frame.origin.x;
         shadeBtn.frame = frame;
         
         
     } completion:^(BOOL finished){//do other thing
     }];
    
    
}

- (void)imgAnimate:(UIButton*)btn{
    
    UIView *view=btn.subviews[0];
    
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         
         
     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.1 animations:
          ^(void){
              
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1, 1.1);
              
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                   
                   
               } completion:^(BOOL finished){//do other thing
               }];
          }];
     }];
    
    
}

-(void)setSelectItem:(NSInteger)index {
    UIButton *preBtn = (UIButton *)[self viewWithTag:index];
    [preBtn setUserInteractionEnabled:YES];
    [preBtn setSelected:NO];

}
@end
