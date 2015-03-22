//
//  HMStatusDetailView.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWStatusDetailView.h"
#import "SWStatusRetweetedView.h"
#import "SWStatusOriginalView.h"
#import "SWStatusOriginalFrame.h"
#import "SWStatusRetweetedFrame.h"
#import "SWStatusDetailFrame.h"
@interface SWStatusDetailView()
@property (nonatomic, weak) SWStatusRetweetedView *retweetedView;
@property (nonatomic, weak) SWStatusOriginalView *originalView;

@end

@implementation SWStatusDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { // 初始化子控件
        self.image = [UIImage resizableImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizableImageWithName:@"timeline_card_top_background_highlighted"];
        // 1.添加原创微博
        [self setupOriginalView];

        // 2.添加转发微博
        [self setupRetweetedView];
        
        
        //能与用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}


/**
 *  添加原创微博
 */
- (void)setupOriginalView
{
    SWStatusOriginalView *originalView = [[SWStatusOriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
}

/**
 *  添加转发微博
 */
- (void)setupRetweetedView
{
    SWStatusRetweetedView *retweetedView = [[SWStatusRetweetedView alloc] init];
    [self addSubview:retweetedView];
    self.retweetedView = retweetedView;
}

- (void)setDetailFrame:(SWStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 1.原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    

    // 2.原创转发的frame数据
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}
@end
