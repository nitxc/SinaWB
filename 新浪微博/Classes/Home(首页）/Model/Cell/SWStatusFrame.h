//
//  SWStatusFrame.h
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWStatus,SWStatusDetailFrame;
@interface SWStatusFrame : NSObject
/**  微博模型 */
@property (nonatomic, strong) SWStatus *status;
/**  微博详细frame */
@property (nonatomic, strong) SWStatusDetailFrame *statusDetailFrame;
/**  微博工具条frame */
@property (nonatomic, assign) CGRect statusToolbarFrame;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
