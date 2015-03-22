//
//  SWRepostsResult.m
//  新浪微博
//
//  Created by apple on 14-7-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWRepostsResult.h"
#import "MJExtension.h"
#import "SWStatus.h"

@implementation SWRepostsResult
- (NSDictionary *)objectClassInArray
{
    return @{@"reposts" : [SWStatus class]};
}
@end
