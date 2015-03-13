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
#import "MJExtension.h"
#import "SWEmotion.h"

@interface SWEmotionKeyboard() <SWEmotionToolbarDelegate>
/** 表情列表 */
@property (nonatomic, weak) SWEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) SWEmotionToolbar *toollbar;

/** 默认表情 */
@property (nonatomic, strong) NSArray *defaultEmotions;
/** emoji表情 */
@property (nonatomic, strong) NSArray *emojiEmotions;
/** 浪小花表情 */
@property (nonatomic, strong) NSArray *lxhEmotions;
@end

@implementation SWEmotionKeyboard

- (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"Emoticons/default/info.plist" ofType:nil];
        self.defaultEmotions = [SWEmotion objectArrayWithFile:plist];
    }
    return _defaultEmotions;
}

- (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"Emoticons/emoji/info.plist" ofType:nil];
        self.emojiEmotions = [SWEmotion objectArrayWithFile:plist];
    }
    return _emojiEmotions;
}

- (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"Emoticons/lxh/info.plist" ofType:nil];
        self.lxhEmotions = [SWEmotion objectArrayWithFile:plist];
    }
    return _lxhEmotions;
}

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
        toollbar.delegate = self;
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
            self.listView.emotions = self.defaultEmotions;
            break;
            
        case SWEmotionTypeEmoji: // Emoji
            self.listView.emotions = self.emojiEmotions;
            break;
            
        case SWEmotionTypeLxh: // 浪小花
            self.listView.emotions = self.lxhEmotions;
            break;
            
        default:
            break;
    }
    
    SWLog(@"%lu %@", (unsigned long)self.listView.emotions.count, [self.listView.emotions firstObject]);
}
@end
