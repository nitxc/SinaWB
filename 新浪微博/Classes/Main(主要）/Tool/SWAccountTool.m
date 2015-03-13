//
//  HMAccountTool.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#define SWAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.arch"]

#import "SWAccountTool.h"
#import "SWAccount.h"

@implementation SWAccountTool

+ (void)save:(SWAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:SWAccountFilepath];
}

+ (SWAccount *)account
{
    // 读取帐号
    SWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SWAccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];

    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}
+ (void)accessTokenWithParam:(SWAccessTokenParam *)param success:(void (^)(SWAccount *))success failure:(void (^)(NSError *))failure
{
     [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[SWAccount class] success:success failure:failure];
}

/**
 NSOrderedAscending = -1L,  升序，越往右边越大
 NSOrderedSame, 相等，一样
 NSOrderedDescending 降序，越往右边越小
 */
@end
