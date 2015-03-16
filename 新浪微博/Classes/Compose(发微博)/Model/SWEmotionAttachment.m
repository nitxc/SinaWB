//
//  HMEmotionAttachment.m
//  黑马微博
//
//  Created by apple on 14-7-18.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWEmotionAttachment.h"
#import "SWEmotion.h"

@implementation SWEmotionAttachment

- (void)setEmotion:(SWEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageWithName:emotion.png];
}

@end
