//
//  SWRegexResult.h
//  新浪微博
//
//  Created by apple on 15-3-18.
//  Copyright (c) 2015年 xc. All rights reserved.
//  用来封装一个匹配结果

#import <Foundation/Foundation.h>

@interface SWRegexResult : NSObject
/**
 *  匹配到的字符串
 */
@property (nonatomic, copy) NSString *string;
/**
 *  匹配到的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  这个结果是否为表情
 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;
@end
