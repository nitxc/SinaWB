//
//  SWCommonGroup.h
//  新浪微博
//
//  Created by apple on 15-3-18.
//  Copyright (c) 2015年 xc. All rights reserved.
//
//  用一个HMCommonGroup模型来描述每组的信息：组头、组尾、这组的所有行模型

#import <Foundation/Foundation.h>

@interface SWCommonGroup : NSObject
/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/** 这组的所有行模型(数组中存放的都是HMCommonItem模型) */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;
@end
