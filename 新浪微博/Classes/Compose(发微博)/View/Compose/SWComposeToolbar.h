//
//  HMComposeToolbar.h
//  黑马微博
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SWComposeToolbarButtonTypeCamera, // 照相机
    SWComposeToolbarButtonTypePicture, // 相册
    SWComposeToolbarButtonTypeMention, // 提到@
    SWComposeToolbarButtonTypeTrend, // 话题
    SWComposeToolbarButtonTypeEmotion // 表情
} SWComposeToolbarButtonType;

@class SWComposeToolbar;

@protocol SWComposeToolbarDelegate <NSObject>

@optional
- (void)composeTool:(SWComposeToolbar *)toolbar didClickedButton:(SWComposeToolbarButtonType)buttonType;

@end

@interface SWComposeToolbar : UIView
@property (nonatomic, weak) id<SWComposeToolbarDelegate> delegate;

/**
 *  是否要显示表情按钮
 */
@property (nonatomic, assign, getter = isShowEmotionButton) BOOL showEmotionButton;
@end
