//
//  HMAccountTool.h
//  黑马微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWBaseTool.h"
@class SWAccessTokenParam,SWAccount;

@interface SWAccountTool : SWBaseTool

/**
 *  存储帐号
 */
+ (void)save:(SWAccount *)account;

/**
 *  读取帐号
 */
+ (SWAccount *)account;


/**
 *  获得accesToken
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)accessTokenWithParam:(SWAccessTokenParam *)param success:(void (^)(SWAccount *account))success failure:(void (^)(NSError *error))failure;

@end
