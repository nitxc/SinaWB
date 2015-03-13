//
//  SWUserTool.m
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWUserTool.h"
#import "MJExtension.h"
#import "SWHttpTool.h"

@implementation SWUserTool
+ (void)userInfoWithParam:(SWUserInfoParam *)param success:(void (^)(SWUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[SWUserInfoResult class] success:success failure:failure];
}
+ (void)unreadCountWithParam:(SWUnreadCountParam *)param success:(void (^)(SWUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[SWUnreadCountResult class] success:success failure:failure];
}
@end
