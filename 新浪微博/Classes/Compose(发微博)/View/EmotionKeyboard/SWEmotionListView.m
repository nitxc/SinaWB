//
//  SWEmotionListView.m
//  新浪微博
//
//  Created by apple on 15-3-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

// 表情的最大行数
#define SWEmotionMaxRows 3
// 表情的最大列数
#define SWEmotionMaxCols 7
// 每页最多显示多少个表情
#define SWEmotionMaxCountPerPage (SWEmotionMaxRows * SWEmotionMaxCols - 1)

#import "SWEmotionListView.h"

@interface SWEmotionListView()
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
        scrollView.backgroundColor = [UIColor redColor];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
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
    SWLog(@"----%d", (int)emotions.count);
    // 设置总页数
    self.pageControl.numberOfPages = (emotions.count + SWEmotionMaxCountPerPage - 1) / SWEmotionMaxCountPerPage;
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
}

@end
