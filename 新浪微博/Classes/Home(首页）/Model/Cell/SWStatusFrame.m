//
//  SWStatusFrame.m
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWStatusFrame.h"
#import "SWStatusDetailFrame.h"
#import "SWStatus.h"


@implementation SWStatusFrame

- (void)setStatus:(SWStatus *)status
{
    _status = status;
    
    // 1.计算微博具体内容（微博整体）
    [self setupStatusDetailFrame];
    
    // 2.计算底部工具条
    [self setupStatusToolbarFrame];
    
    // 3.计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.statusToolbarFrame);
}

/**
 *  计算微博具体内容（微博整体）
 */
- (void)setupStatusDetailFrame
{
    SWStatusDetailFrame *detailFrame = [[SWStatusDetailFrame alloc] init];
    detailFrame.status = self.status;
    self.statusDetailFrame = detailFrame;
}

/**
 *  计算底部工具条
 */
- (void)setupStatusToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.statusDetailFrame.frame);
    CGFloat toolbarW = SWScreenWidth;
   
    CGFloat toolbarH = SWStatusToolbarWidth;
    self.statusToolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end
