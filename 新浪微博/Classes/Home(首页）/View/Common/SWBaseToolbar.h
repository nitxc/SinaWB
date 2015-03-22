//
//  SWBaseToolbar.h
//  新浪微博
//
//  Created by xc on 15/3/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWStatus;
@interface SWBaseToolbar : UIView
@property (nonatomic,strong) SWStatus *status;
@property (nonatomic, strong) NSMutableArray *btns;

@end
