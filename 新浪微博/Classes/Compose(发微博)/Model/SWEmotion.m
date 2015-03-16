//
//  SWEmotion.m
//  新浪微博
//
//  Created by apple on 14-7-15.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWEmotion.h"
#import "NSString+Emoji.h"

@implementation SWEmotion
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}

- (void)setCode:(NSString *)code
{
    _code = [code copy];
    if (!code) return;
    self.emoji = [NSString emojiWithStringCode:code];
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}
- (BOOL)isEqual:(SWEmotion *)emotion
{
    if (emotion.code) {
        return [self.code isEqualToString:emotion.code];
    }else{
        return [self.png isEqualToString:emotion.png] && [self.chs isEqualToString:emotion.chs];
    }
}
@end
