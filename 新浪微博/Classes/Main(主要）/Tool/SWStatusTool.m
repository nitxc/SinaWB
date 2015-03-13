//
//  HMStatusTool.m
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWStatusTool.h"
#import "SWHttpTool.h"
#import "MJExtension.h"

@implementation SWStatusTool

+ (void)homeStatusesWithParam:(SWHomeStatusesParam *)param success:(void (^)(SWHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param resultClass:[SWHomeStatusesResult class] success:success failure:failure];
}
/**
 *  发送微博业务处理类
 *
 *  @param param   微博模型参数
 *  @param success 成功回调的block
 *  @param failure 失败回调的block
 */
+ (void)sendStatusWithParam:(SWSendStatusParam *)param success:(void (^)(SWSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:[SWSendStatusResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(SWSendStatusParam *)param images:(NSArray *)images success:(void (^)(SWSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" param:param images:images resultClass:[SWSendStatusResult class] success:success failure:failure];
}

@end
