//
//  SWPhoto.h
//  新浪微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWPhoto : NSObject
/** 缩略图 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/** 中等尺寸图片地址，没有时不返回此字段 */
@property (nonatomic, copy) NSString *bmiddle_pic;

/** 原始图片地址，没有时不返回此字段 */

@property (nonatomic, copy) NSString *original_pic;
@end
