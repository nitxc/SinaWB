//
//  HMEmotionListView.h
//  新浪微博
//
//  Created by apple on 15-4-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//  表情列表（能展示多页表情）

#import <UIKit/UIKit.h>

@interface SWEmotionListView : UIView
/** 需要展示的所有表情 */
@property (nonatomic, strong) NSArray *emotions;
@end
