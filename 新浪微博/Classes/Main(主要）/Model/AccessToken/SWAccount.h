//
//  HMAccount.h
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//  帐号模型

#import <Foundation/Foundation.h>

@interface SWAccount : NSObject  <NSCoding>
/** string 	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/** string 	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSString *expires_in;

/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;

/** string 	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *userName;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
