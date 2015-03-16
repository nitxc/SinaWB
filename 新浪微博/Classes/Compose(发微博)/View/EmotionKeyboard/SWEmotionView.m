//
//  SWEmotionView.m
//  新浪微博
//
//  Created by apple on 15-3-17.
//  Copyright (c) 2014年 xc. All rights reserved.
//

#import "SWEmotionView.h"
#import "SWEmotion.h"
@implementation SWEmotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(SWEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.code) { // emoji表情
        // emotion.code == 0x1f603 --> \u54367
        // emoji的大小取决于字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    } else { // 图片表情
       
        [self setImage:[UIImage imageWithName:emotion.png] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
