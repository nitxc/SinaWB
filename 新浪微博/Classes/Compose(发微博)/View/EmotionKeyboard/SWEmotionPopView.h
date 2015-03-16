//
//  HMEmotionPopView.h
//  黑马微博
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWEmotionView;

@interface SWEmotionPopView : UIView
+ (instancetype)popView;

/**
 *  显示表情弹出控件
 *
 *  @param emotionView 从哪个表情上面弹出
 */
- (void)showFromEmotionView:(SWEmotionView *)fromEmotionView;
/**
 *  隐藏
 */
- (void)dismiss;
@end
