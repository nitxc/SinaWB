//
//  HMEmotionToolbar.h
//  黑马微博
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//  表情底部的工具条

#import <UIKit/UIKit.h>
@class SWEmotionToolbar;

typedef enum {
    SWEmotionTypeRecent, // 最近
    SWEmotionTypeDefault, // 默认
    SWEmotionTypeEmoji, // Emoji
    SWEmotionTypeLxh // 浪小花
} SWEmotionType;

@protocol SWEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(SWEmotionToolbar *)toolbar didSelectedButton:(SWEmotionType)emotionType;
@end

@interface SWEmotionToolbar : UIView
@property (nonatomic, weak) id<SWEmotionToolbarDelegate> delegate;
@end
