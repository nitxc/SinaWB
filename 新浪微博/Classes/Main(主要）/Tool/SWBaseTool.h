//
//  HMBaseTool.h
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//  最基本的业务工具类

#import <Foundation/Foundation.h>

@interface SWBaseTool : NSObject
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param images:(NSArray *)images resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
