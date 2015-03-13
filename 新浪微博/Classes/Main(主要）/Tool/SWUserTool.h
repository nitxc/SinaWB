//
//  SWUserTool.h
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWUserInfoParam.h"
#import "SWUserInfoResult.h"
#import "SWBaseTool.h"
#import "SWUnreadCountParam.h"
#import "SWUnreadCountResult.h"

@interface SWUserTool:SWBaseTool
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)userInfoWithParam:(SWUserInfoParam *)param success:(void (^)(SWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  获取用户未读信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)unreadCountWithParam:(SWUnreadCountParam *)param success:(void (^)(SWUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
