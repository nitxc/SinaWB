//
//  HMStatusOriginalView.h
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWStatusOriginalView;
@protocol SWStatusOriginalViewDelegate<NSObject>

- (void)statusOriginalViewDidClickedMoreButton:(SWStatusOriginalView *) statusOriginalView;

@end

@class SWStatusOriginalFrame;
@interface SWStatusOriginalView : UIImageView
@property (nonatomic, strong) SWStatusOriginalFrame *originalFrame;

@property (nonatomic, weak) id<SWStatusOriginalViewDelegate> delegate;

@end
