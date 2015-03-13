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
@implementation SWStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [SWPhoto class]};
}
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 获得微博发布的具体时间
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
@end
