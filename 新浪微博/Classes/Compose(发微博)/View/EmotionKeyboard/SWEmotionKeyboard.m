//
//  SWEmotionKeyboard.h
//  新浪微博
//
//  Created by apple on 15-3-13.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWEmotionKeyboard.h"
#import "SWEmotionListView.h"
#import "SWEmotionToolbar.h"
#import "SWEmotion.h"
#import "SWEmotionTool.h"
@interface SWEmotionKeyboard() <SWEmotionToolbarDelegate>
/** 表情列表 */
@property (nonatomic, weak) SWEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) SWEmotionToolbar *toollbar;

@end

@implementation SWEmotionKeyboard


+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        SWEmotionListView *listView = [[SWEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        SWEmotionToolbar *toollbar = [[SWEmotionToolbar alloc] init];
        toollbar.currentButtonType = [SWEmotionTool recentEmotions].count>0?SWEmotionTypeRecent:SWEmotionTypeDefault;
        toollbar.delegate = self;//设置代理：并默认选择默认表情：但是需要判断最近使用的有无
        [self addSubview:toollbar];
        self.toollbar = toollbar;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
}

#pragma mark - SWEmotionToolbarDelegate
- (void)emotionToolbar:(SWEmotionToolbar *)toolbar didSelectedButton:(SWEmotionType)emotionType
{
    switch (emotionType) {
        case SWEmotionTypeDefault:// 默认
            //传递默认表情模型数据
            self.listView.emotions = [SWEmotionTool defaultEmotions];
            break;
            
        case SWEmotionTypeEmoji: // Emoji
             //传递Emoji表情模型数据
            self.listView.emotions = [SWEmotionTool emojiEmotions];
            break;
            
        case SWEmotionTypeLxh: // 浪小花
             //传递浪小花表情模型数据
            self.listView.emotions = [SWEmotionTool lxhEmotions];
            break;
        case SWEmotionTypeRecent://最近
            self.listView.emotions = [SWEmotionTool recentEmotions];
        default:
            break;
    }

}
@end
