//
//  SWEmotionGroup.m
//  新浪微博
//
//  Created by xc on 15/3/13.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWEmotionGroup.h"
#import "MJExtension.h"
#import "SWEmotion.h"
@implementation SWEmotionGroup

- (NSDictionary *)objectClassInArray
{
    return @{@"emoticon_group_emoticons" : [SWEmotion class]};
}
@end
