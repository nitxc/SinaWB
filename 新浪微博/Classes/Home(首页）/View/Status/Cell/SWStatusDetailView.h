//
//  HMStatusDetailView.h
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//  微博的具体内容 = 原创微博 + 转发微博

#import <UIKit/UIKit.h>
@class SWStatusDetailFrame,SWStatusOriginalView;
@interface SWStatusDetailView : UIImageView
@property (nonatomic, strong) SWStatusDetailFrame *detailFrame;

@end
