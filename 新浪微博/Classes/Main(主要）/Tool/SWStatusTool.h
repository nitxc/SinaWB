//
//  SWStatusTool.h
//  新浪微博
//
//  Created by apple on 15-3-11.
//  Copyright (c) 2015年 xc. All rights reserved.
//  微博业务类：处理跟微博相关的一切业务，比如加载微博数据、发微博、删微博

#import <Foundation/Foundation.h>
#import "SWHomeStatusesParam.h"
#import "SWHomeStatusesResult.h"
#import "SWSendStatusParam.h"
#import "SWSendStatusResult.h"
#import "SWBaseTool.h"
#import "SWCommentsParam.h"
#import "SWCommentsResult.h"
#import "SWRepostsParam.h"
#import "SWRepostsResult.h"
@interface SWStatusTool : SWBaseTool

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParam:(SWHomeStatusesParam *)param success:(void (^)(SWHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)sendStatusWithParam:(SWSendStatusParam *)param success:(void (^)(SWSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param images  图片数组
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中
 */
+ (void)sendStatusWithParam:(SWSendStatusParam *)param images:(NSArray *)images success:(void (^)(SWSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载评论数据
 */
+ (void)commentsWithParam:(SWCommentsParam *)param success:(void (^)(SWCommentsResult *result))success failure:(void (^)(NSError *error))failure;
/**
 *  加载转发数据
 */
+ (void)repostsWithParam:(SWRepostsParam *)param success:(void (^)(SWRepostsResult *result))success failure:(void (^)(NSError *error))failure;
@end
