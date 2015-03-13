//
//  HMHomeStatusesResult.h
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface SWHomeStatusesResult : NSObject
/** 微博数组（装着SWStatus模型） */
@property (nonatomic, strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;
@end
