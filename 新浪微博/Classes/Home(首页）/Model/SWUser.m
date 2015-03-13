//
//  SWUser.m
//  新浪微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWUser.h"

@implementation SWUser
- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
}

@end
