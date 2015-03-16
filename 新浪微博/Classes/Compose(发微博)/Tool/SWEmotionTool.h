//
//  SWEmotionTool.h
//  新浪微博
//
//  Created by apple on 15-3-17.
//  Copyright (c) 2015年 xc. All rights reserved.
//  管理表情数据：加载表情数据、存储表情使用记录

#import <Foundation/Foundation.h>
@class SWEmotion;

@interface SWEmotionTool : NSObject
/**
 *  默认表情
 */
+ (NSArray *)defaultEmotions;
/**
 *  emoji表情
 */
+ (NSArray *)emojiEmotions;
/**
 *  浪小花表情
 */
+ (NSArray *)lxhEmotions;
/**
 *  最近表情
 */
+ (NSArray *)recentEmotions;

/**
 *  保存最近使用的表情
 */
+ (void)addRecentEmotion:(SWEmotion *)emotion;
/**
 *  根据表情描述返回表情模型
 */
+ (SWEmotion *)emotionWithDesc:(NSString *)desc;
@end
