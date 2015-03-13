//
//  SWBaseTool.m
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWBaseTool.h"
#import "SWHttpTool.h"
#import "MJExtension.h"

@implementation SWBaseTool
+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [SWHttpTool get:url parameters:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    
    [SWHttpTool post:url parameters:params success:^(id responseObj) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)postWithUrl:(NSString *)url param:(id)param images:(NSArray *)images resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    
    [SWHttpTool post:url parameters:params fileData:^(id<AFMultipartFormData> formData) {
        //目前新浪开放的发微博接口 最多 只能上传一张图片
        UIImage *image = [images firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        // 拼接文件参数
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
    } success:^(id responseObj) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObj];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
