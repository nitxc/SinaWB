//
//  SWLink.h
//  新浪微博
//
//  Created by xc on 15/3/16.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWLink : UIView
/** 匹配的文本 */
@property (nonatomic, copy) NSString *text;

/** 匹配文字的范围 */
@property (nonatomic, assign) NSRange range;

/** 选中得范围 */
@property (nonatomic, strong) NSArray *rects;



@end
