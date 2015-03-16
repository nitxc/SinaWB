//
//  SWEmotionListView.m
//  新浪微博
//
//  Created by apple on 15-3-15.
//  Copyright (c) 2015年 xc. All rights reserved.
//



#import "SWEmotionListView.h"
#import "SWEmotionGridView.h"
@interface SWEmotionListView()<UIScrollViewDelegate>
/** 显示所有表情的UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 显示页码的UIPageControl */
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation SWEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 通过KVC修改系统自带的图片
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    // 设置总页数
    int totalPages = ((int)emotions.count + SWEmotionMaxCountPerPage - 1) / SWEmotionMaxCountPerPage;
    int currentGridViewCount = (int)self.scrollView.subviews.count;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    self.pageControl.hidesForSinglePage = YES;//一页时候隐藏
    
    //循环利用
    // 决定scrollView显示多少页表情
    for (int i = 0; i<totalPages; i++) {
        // 获得i位置对应的SWEmotionGridView
        SWEmotionGridView *gridView = nil;
        if (i >= currentGridViewCount) { // 说明SWEmotionGridView的个数不够
            gridView = [[SWEmotionGridView alloc] init];
            [self.scrollView addSubview:gridView];
        } else { // 说明SWEmotionGridView的个数足够，从self.scrollView.subviews中取出SWEmotionGridView
            gridView = self.scrollView.subviews[i];
        }
        
        // 给SWEmotionGridView设置表情数据
        int loc = i * SWEmotionMaxCountPerPage;
        int len = SWEmotionMaxCountPerPage;
        if (loc + len > emotions.count) { // 对越界进行判断处理
            len = (int)emotions.count - loc;
        }
        NSRange gridViewEmotionsRange = NSMakeRange(loc, len);
        NSArray *gridViewEmotions = [emotions subarrayWithRange:gridViewEmotionsRange];
        gridView.emotions = gridViewEmotions;
        gridView.hidden = NO;
    }
    
    // 隐藏后面的不需要用到的gridView
    for (int i = totalPages; i<currentGridViewCount; i++) {
        SWEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    
    // 重新布局子控件
    [self setNeedsLayout];
    
    // 表情滚动到最前面
    self.scrollView.contentOffset = CGPointZero;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    // 3.设置UIScrollView内部控件的尺寸
    int count = (int)self.pageControl.numberOfPages;
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    //设置滚动范围
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<count; i++) {
        SWEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = gridW;
        gridView.height = gridH;
        gridView.x = i * gridW;
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}
@end
