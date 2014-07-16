//
//  NWBannerView.m
//  APPVV
//
//  Created by Anselz on 14-7-6.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import "NWBannerView.h"
#import "UIImageView+WebCache.h"

typedef void (^ClickBlock)(NSInteger selectIndex);
@interface NWBannerView ()<UIScrollViewDelegate>
{
    NSInteger countPages;
    NSInteger currentPage;
    NSTimer *timer;
}
@property (copy,nonatomic) ClickBlock clickBlock;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation NWBannerView
@synthesize scrollView = scrollView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    currentPage = -1;
    countPages = 0;
    if (!scrollView) {
        scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator= NO;
        [self addSubview:scrollView];
    }
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 10)];
        [self addSubview:_pageControl];
    }
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
    }
  
}
-(void)setImageURLs:(NSArray *)imageArray withClickBlock:(void (^) (NSInteger selectIndex))clickblock
{
    if (clickblock) {
        self.clickBlock = clickblock;
    }
    CGFloat orignX = 0;
    int i = 1000;
    for (NSString *image in imageArray) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(orignX, 0, self.frame.size.width, self.frame.size.height)];
        [imageView setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageAction:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        orignX = orignX + self.frame.size.width;
        [scrollView addSubview:imageView];
        i ++;
    }
    countPages = imageArray.count;
    _pageControl.numberOfPages = countPages;
    _pageControl.currentPage = 0;
    scrollView.contentSize = CGSizeMake(orignX, self.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView {
    int page = _scrollView.contentOffset.x / 320;
    _pageControl.currentPage = page;
    currentPage = page;
}

-(void)autoScrollView
{
    currentPage ++;
    if (currentPage == countPages ) {
        currentPage = 0;
    }
    [scrollView setContentOffset:CGPointMake(currentPage*self.frame.size.width, 0) animated:YES];
}

-(void)clickImageAction:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIView *view = tap.view;
    self.clickBlock(view.tag - 1000);
}
@end
