//
//  SWEmotionTextView.h
//  新浪微博
//
//  Created by apple on 15-3-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWTextView.h"
@class SWEmotion;

@interface SWEmotionTextView : SWTextView
/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(SWEmotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;

@end
