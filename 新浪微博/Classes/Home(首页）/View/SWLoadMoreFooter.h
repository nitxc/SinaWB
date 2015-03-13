//
//  HMLoadMoreFooter.h
//  黑马微博
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWLoadMoreFooter : UIView
+ (instancetype)footer;

- (void)beginRefreshing;
- (void)endRefreshing;

@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;
@end
