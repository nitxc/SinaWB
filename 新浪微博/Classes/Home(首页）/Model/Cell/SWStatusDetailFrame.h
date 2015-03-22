//
//  SWStatusDetailFrame.h
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWStatus,SWStatusOriginalFrame,SWStatusRetweetedFrame;
@interface SWStatusDetailFrame : NSObject

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 微博模型 */
@property (nonatomic, strong) SWStatus *status;

/** 转发微博frame */
@property (nonatomic, strong)  SWStatusRetweetedFrame *retweetedFrame;

/** 原始微博frame */
@property (nonatomic, strong) SWStatusOriginalFrame *originalFrame;


@end
