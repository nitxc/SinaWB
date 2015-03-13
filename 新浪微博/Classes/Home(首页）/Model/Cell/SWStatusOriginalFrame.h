//
//  SWStatusOrginal.h
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWStatus;
@interface SWStatusOriginalFrame : NSObject
/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 头像 */
@property (nonatomic, assign) CGRect iconFrame;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipFrame;
/** 更多图标 */
@property (nonatomic, assign) CGRect moreFrame;
/** 自己的frame */
@property (nonatomic, assign) CGRect frame;
/** 相册的frame */
@property (nonatomic, assign) CGRect photosFrame;
/** 微博数据 */
@property (nonatomic, strong) SWStatus *status;
@end
