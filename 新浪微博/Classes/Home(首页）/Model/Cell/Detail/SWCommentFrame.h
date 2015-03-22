//
//  SWCommentFrame.h
//  新浪微博
//
//  Created by xc on 15/3/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  SWComment;
@interface SWCommentFrame : NSObject

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 评论模型 */
@property (nonatomic, strong) SWComment *comment;

/** 用户头像的frame **/
@property (nonatomic, assign) CGRect iconFrame;

/** 用户昵称的frame **/
@property (nonatomic, assign) CGRect nameFrame;

/** 用户VIP的frame **/
@property (nonatomic, assign) CGRect vipFrame;

/** 评论时间的frame **/
@property (nonatomic, assign) CGRect timeFrame;

/** 评论内容的frame **/
@property (nonatomic, assign) CGRect textFrame;

@end
