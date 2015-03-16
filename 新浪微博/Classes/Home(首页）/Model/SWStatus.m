//
//  SWStatus.m
//  新浪微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWStatus.h"
#import "MJExtension.h"
#import "SWPhoto.h"
#import "NSDate+Estension.h"
#import "SWRegexResult.h"
#import "RegexKitLite.h"
#import "SWEmotionAttachment.h"
#import "SWEmotionTool.h"
#import "SWUser.h"
@implementation SWStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [SWPhoto class]};
}
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH24:mm:ss Z yyyy";
    //若在中文语言环境是无法解析英语格式的日期：需要设置解析的语言环境
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];

    // 获得微博发布的具体时间 en
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

- (void)setSource:(NSString *)source
{
    
    if (source==nil||[source isEqualToString:@""]) return;
    
    
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    // 开始截取
    NSString *subsource = [source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自 %@",subsource];
    
    
    
}
/*
 *
 *  根据字符串计算出所有的匹配结果（已经排好序）
 *
 *  @param text 字符串内容
 */
- (NSArray *)regexResultsWithText:(NSString *)text
{
    // 用来存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    // 匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
  
    
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        SWRegexResult *regxResult = [[SWRegexResult alloc] init];
        regxResult.string = *capturedStrings;
        regxResult.range = *capturedRanges;
        regxResult.emotion = YES;
        [regexResults addObject:regxResult];
    }];
    
    // 匹配非表情
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        SWRegexResult *regxResult = [[SWRegexResult alloc] init];
        regxResult.string = *capturedStrings;
        regxResult.range = *capturedRanges;
        regxResult.emotion = NO;
        [regexResults addObject:regxResult];
    }];
    
    // 排序
    [regexResults sortUsingComparator:^NSComparisonResult(SWRegexResult *rr1, SWRegexResult *rr2) {
        int loc1 = (int)rr1.range.location;
        int loc2 = (int)rr2.range.location;
        return [@(loc1) compare:@(loc2)];
        
    }];
    return regexResults;
}

- (void)createAttributedText
{
    if (self.text == nil || self.user == nil) return;
    
    if (_retweeded) {
        NSString *totalString = [NSString stringWithFormat:@"@%@ : %@",_user.name,_text];
        self.attributedText = [self attributedStringWithText:totalString];
        
    }else{
        self.attributedText = [self attributedStringWithText:self.text];

    }
    
    
    
}

- (void)setRetweeted_status:(SWStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    retweeted_status.retweeded = YES;
    [self createAttributedText];
}
- (void)setUser:(SWUser *)user
{
    _user = user;
    
    [self createAttributedText];
}

- (void)setRetweeded:(bool)retweeded
{
    _retweeded = retweeded;
   
    [self createAttributedText];
}
/**
 *  功能描述：根据文字内容返回富文本
 *
 *  @param text 文字文本
 *
 *  @return 富文本
 */
- (NSAttributedString *)attributedStringWithText:(NSString *) text
{
    //对有表情的内容替换我们富文本图片内容
    // 链接、@提到、#话题#
    
    // 1.匹配字符串
    NSArray *regexResults = [self regexResultsWithText:text];
    
    // 2.根据匹配结果，拼接对应的图片表情和普通文本
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    
    // 遍历
    [regexResults enumerateObjectsUsingBlock:^(SWRegexResult *result, NSUInteger idx, BOOL *stop) {
        
        SWEmotion *emotion = nil;
        if (result.isEmotion) { // 表情
            emotion = [SWEmotionTool emotionWithDesc:result.string];
            
        }
        //如果找到表情才设置表情富文本
        if (emotion) {
            // 创建附件对象
            SWEmotionAttachment *attach = [[SWEmotionAttachment alloc] init];
            // 传递表情
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, SWStatusRichTextFont.lineHeight, SWStatusRichTextFont.lineHeight);
            
            // 将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedText appendAttributedString:attachString];
        }else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            //如果是转发微博设置字体颜色
            if (_retweeded) {
                //设置整个字体颜色
                [substr addAttribute:NSForegroundColorAttributeName value:SWStatusRetweededTextColor range:NSMakeRange(0, substr.length)];
                
            }
            
            // 匹配#话题#
            NSString *trendRegex = @"#([^\\#|.]+)#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:SWStatusHighTextColor range:*capturedRanges];
                 [substr addAttribute:SWLinkAttr value:*capturedStrings range:*capturedRanges];
                
            }];
            
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-]+ ?";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:SWStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:SWLinkAttr value:*capturedStrings range:*capturedRanges];
            }];
            
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:SWStatusHighTextColor range:*capturedRanges];
                [substr addAttribute:SWLinkAttr value:*capturedStrings range:*capturedRanges];
            }];
            
            [attributedText appendAttributedString:substr];
        }
    }];
    
    // 设置字体
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, attributedText.length)];
  
    return attributedText;
}

/**
 *  重写内容：若有表情需要替换
 *
 *  @param text 普通文本
 */
- (void)setText:(NSString *)text
{
    _text = [text copy];
    
    [self createAttributedText];
}
@end
