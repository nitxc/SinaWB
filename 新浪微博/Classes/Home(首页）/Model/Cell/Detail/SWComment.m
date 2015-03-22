//
//  SWComment.m
//  新浪微博
//
//  Created by apple on 15-3-25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWComment.h"
#import "NSDate+Estension.h"
#import "SWEmotionTool.h"
#import "SWEmotionAttachment.h"
#import "RegexKitLite.h"
#import "SWRegexResult.h"
@implementation SWComment
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH24:mm:ss Z yyyy";
    //若在中文语言环境是无法解析英语格式的日期：需要设置解析的语言环境
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    // 获得微博发布的具体时间 en
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 判断是否为今年

    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    return [fmt stringFromDate:createDate];
    
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
    if (self.text == nil) return;
    
    self.attributedText = [self attributedStringWithText:self.text];
   
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
            attach.bounds = CGRectMake(0, -3, SWCommentRichTextFont.lineHeight, SWCommentRichTextFont.lineHeight);
            
            // 将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedText appendAttributedString:attachString];
        }else { // 非表情（直接拼接普通文本）
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
           [substr addAttribute:NSForegroundColorAttributeName value:SWStatusRetweededTextColor range:NSMakeRange(0, substr.length)];
            
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
    [attributedText addAttribute:NSFontAttributeName value:SWCommentRichTextFont range:NSMakeRange(0, attributedText.length)];
    
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
