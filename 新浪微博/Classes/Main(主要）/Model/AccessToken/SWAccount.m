//
//  HMAccount.m
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWAccount.h"

@implementation SWAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    SWAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    
    return account;
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    [encoder encodeObject:self.userName forKey:@"userName"];
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = [expires_in copy];
    // 需要重新设置过期时间参数
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    _expires_time = [now dateByAddingTimeInterval:expires_in.doubleValue];
}

@end
