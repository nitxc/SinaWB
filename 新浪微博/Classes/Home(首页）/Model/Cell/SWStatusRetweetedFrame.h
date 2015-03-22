//
//  SWStatusRetweetedFrame.h
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWStatus;
@interface SWStatusRetweetedFrame : NSObject
/** 昵称 */
//@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 转发微博模型 */
@property (nonatomic, strong) SWStatus *retweetedStatus;
/** 相册的frame */
@property (nonatomic, assign) CGRect photosFrame;
/** 自己的frame */
@property (nonatomic, assign) CGRect frame;
/** 工具条frame */
@property (nonatomic, assign) CGRect toolbarFrame;

@end
