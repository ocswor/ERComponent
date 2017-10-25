//
//  ERCirclePicView.m
//  ERComponent_Example
//
//  Created by eric on 2017/10/11.
//  Copyright © 2017年 jialianghappy1314@163.com. All rights reserved.
//

#import "ERCirclePicView.h"
static NSInteger const radio = 5;
@interface ERCirclePicView ()<UIScrollViewDelegate>
{
    NSInteger _currentPage;
}


/**
 *  用于加载图片的代码块, 必须有值
 */
@property (nonatomic, strong) LoadImageBlock loadBlock;

/**
 *  记录着根据模型数组, 添加的imageView控件
 */
@property (nonatomic, strong) NSMutableArray <UIImageView *>*pics;
/**
 *  存放图片的内容视图
 */
@property (nonatomic, strong) UIScrollView *contentView;
/**
 *  页码指示
 */
@property (nonatomic, strong) UIPageControl *pageControl;
/**
 *  自动滚动的timer
 */
@property (nonatomic, strong) NSTimer *scrollTimer;

@end

@implementation ERCirclePicView


+(instancetype)initWithFrame:(CGRect)frame LoadImageBlock:(LoadImageBlock)loadBlock{
    
    ERCirclePicView *circlePicView = [[ERCirclePicView alloc]initWithFrame:frame];
    circlePicView.loadBlock = loadBlock;
    return circlePicView;
    
}

#pragma mark - 属性懒加载

-(NSTimer *)scrollTimer {
    if (_scrollTimer == nil) {
        _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScrollNextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    }
    return _scrollTimer;
}

-(UIScrollView *)contentView {
    if (_contentView == nil) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.pagingEnabled = YES;
        contentView.showsHorizontalScrollIndicator = NO;
        _contentView = contentView;
        _contentView.delegate = self;
        [self addSubview:contentView];
    }
    return _contentView;
}

-(UIPageControl *)pageControl {
    if (_pageControl == nil) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

-(NSMutableArray<UIImageView *> *)pics
{
    if (_pics == nil) {
        _pics = [NSMutableArray array];
    }
    return _pics;
}

-(void)setPicModels:(NSArray<id <ERCircleModelProtocol>> *)picModels
{
    _picModels = picModels;
    
    // 1. 移除之前控件
    [self.pics enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.pics = nil;
    
    // 2. 根据模型添加新的控件
    NSInteger baseCount = picModels.count;
    NSInteger count = baseCount;
    if (baseCount > 1) {
        count = baseCount * radio;
    }
    for (int i = 0; i< count; i++) {
        
        id<ERCircleModelProtocol> picM = picModels[i % baseCount];
        // 1. 创建控件
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = self.pics.count;
        //        imageView.image = [UIImage imageNamed:@"bg_focusImage_loading"];
        // 2. 设置图片(SDWebImage)
        
        if (self.loadBlock) {
            self.loadBlock(imageView, picM.ERImgURL);
        }
        
        // 3. 添加手势, 点击图片跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToLink:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        // 4. 添加到父控件, 以及使用数组保存
        [self.contentView addSubview:imageView];
        [self.pics addObject:imageView];
        
    }
    
    
    self.pageControl.numberOfPages = picModels.count;
    
    [self setNeedsLayout];
    
    if (picModels.count > 1) {
        [self.scrollTimer fire];
    }else {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
    
}
#pragma mark - 私有方法

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
    
    NSInteger count = self.pics.count;
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    for(int i = 0;i < count;i++) {
        UIImageView *imageView = self.pics[i];
        imageView.frame = CGRectMake(i * width, 0, width, height);
        
    }
    
    self.contentView.contentSize = CGSizeMake(width * count, 0);
    [self scrollViewDidEndDecelerating:self.contentView];
}
- (void)autoScrollNextPage {
    NSInteger page = _currentPage + 1;
    [self.contentView setContentOffset:CGPointMake(self.contentView.frame.size.width * page, 0) animated:YES];
}

- (void)jumpToLink:(UITapGestureRecognizer *)gester {
    
    UIView *imageView = gester.view;
    NSInteger tag = imageView.tag % self.picModels.count;
    id<ERCircleModelProtocol> adM = self.picModels[tag];
    
    if (adM.clickBlock != nil) {
        adM.clickBlock();
    }
    
    
}

#pragma mark - UISCrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.pics.count > 1) {
        [self scrollTimer];
    }

}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
    
}

- (void)caculateCurrentPage: (UIScrollView *)scrollView {
    
    if (self.picModels.count == 0) {
        return;
    }
    if (self.picModels.count == 1) {
        _currentPage = 1;
        if ([self.delegate respondsToSelector:@selector(circlePicViewDidScrollPicModel:)]) {
            [self.delegate circlePicViewDidScrollPicModel:self.picModels[self.pageControl.currentPage]];
        }
        return;
    }
    // 确认中间区域
    NSInteger min = self.picModels.count * (radio / 2);
    NSInteger max = self.picModels.count * (radio / 2 + 1);
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page % self.picModels.count;
    
    if (page < min || page > max) {
        page = min + page % self.picModels.count;
        [scrollView setContentOffset:CGPointMake(page * scrollView.frame.size.width, 0)];
    }
    
    _currentPage = page;
    
    
    
    if ([self.delegate respondsToSelector:@selector(circlePicViewDidScrollPicModel:)]) {
        [self.delegate circlePicViewDidScrollPicModel:self.picModels[self.pageControl.currentPage]];
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
