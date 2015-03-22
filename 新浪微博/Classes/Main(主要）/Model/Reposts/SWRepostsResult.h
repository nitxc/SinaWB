//
//  SWRepostsResult.h
//  新浪微博
//
//  Created by apple on 15-3-25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWRepostsResult : NSObject
/** 转发数组 */
@property (nonatomic, strong) NSArray *reposts;
/** 转发总数 */
@property (nonatomic, assign) int total_number;
@end
