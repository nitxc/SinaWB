//
//  SWStatusDetailFrame.m
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//  微博详细frame模型
//

#import "SWStatusDetailFrame.h"
#import "SWStatusOriginalFrame.h"
#import "SWStatusRetweetedFrame.h"
#import "SWStatus.h"
@implementation SWStatusDetailFrame

- (void)setStatus:(SWStatus *)status
{
    _status = status;
    
    // 1.计算原创微博的frame
    SWStatusOriginalFrame *originalFrame = [[SWStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    // 2.计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        SWStatusRetweetedFrame *retweetedFrame = [[SWStatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = SWStatusCellMargin;
    CGFloat w = SWScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}

@end
