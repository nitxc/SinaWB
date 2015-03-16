//
//  SWEmotion.h
//  新浪微博
//
//  Created by apple on 15-3-15.
//  Copyright (c) 2015年 xc. All rights reserved.
//  表情

#import <Foundation/Foundation.h>

@interface SWEmotion : NSObject<NSCoding>
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的文字t描述 */
@property (nonatomic, copy) NSString *cht;
/** 表情的文png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的编码 */
@property (nonatomic, copy) NSString *code;
/** emoji表情的字符 */
@property (nonatomic, copy) NSString *emoji;
@end
