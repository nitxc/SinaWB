//
//  HMHomeStatusesParam.m
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWHomeStatusesParam.h"

@implementation SWHomeStatusesParam
- (NSNumber *)count
{
    return _count ? _count : @20;
}
@end
