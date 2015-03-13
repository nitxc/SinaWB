//
//  SWHttpTool.h
//  新浪微博
//
//  Created by xc on 15/3/10.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface SWHttpTool : NSObject

/**
 *  get请求
 *
 *  @param url        请求路径
 *  @param parameters 请求普通参数
 *  @param success    成功返回所需要执行的block
 *  @param error      失败返回所需要执行block
 */
+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id reponseObject)) success failure:(void (^)(NSError *)) error;
/**
 *  post请求（不带文件流传输）
 *
 *  @param url        请求路径
 *  @param parameters 请求普通参数
 *  @param success    成功返回所需要执行的block
 *  @param error      失败返回所需要执行block
 */
+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id reponseObject)) success failure:(void (^)(NSError *)) failure;
/**
 *  post请求（带文件上传）
 *
 *  @param url        请求路径
 *  @param parameters 请求普通参数
 *  @param fileData   传输的文件流
 *  @param success    成功返回所需要执行的block
 *  @param failure    失败返回所需要执行block
 */
+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters fileData:(void (^)(id<AFMultipartFormData> formData)) fileData success:(void (^)(id reponseObject)) success failure:(void (^)(NSError *)) failure;
/**
 *  监控网络状态
 *
 *  @param status 网络状态类型
 */
+ (void)monitoringReachabilityStatus:(void (^)(AFNetworkReachabilityStatus)) statusBlock;
/**
 *  是否展示网络激活指示器
 */
+ (void)showNetworkActivityIndicator;
@end
