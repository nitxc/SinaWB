//
//  HMTabBar.h
//  黑马微博
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWTabBar;

@protocol SWTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(SWTabBar *)tabBar;

@end

@interface SWTabBar : UITabBar
@property (nonatomic, weak) id<SWTabBarDelegate> tarbarDelegate;
@end
