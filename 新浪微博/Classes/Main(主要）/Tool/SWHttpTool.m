//
//  SWHttpTool.m
//  新浪微博
//
//  Created by xc on 15/3/10.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWHttpTool.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation SWHttpTool

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送GET请求
    [mgr GET:url parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             success(responseObj);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:url parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters fileData:(void (^)(id<AFMultipartFormData>))fileData success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        fileData(formData);
    }success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              success(responseObj);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+ (void)monitoringReachabilityStatus:(void (^)(AFNetworkReachabilityStatus))statusBlock
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status) {
            statusBlock(status);

        }
    }];
    // 开始监控
    [mgr startMonitoring];

}

+ (void)showNetworkActivityIndicator
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}
@end
