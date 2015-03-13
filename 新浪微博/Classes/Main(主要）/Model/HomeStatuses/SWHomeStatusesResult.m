//
//  HMHomeStatusesResult.m
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWHomeStatusesResult.h"
#import "MJExtension.h"
#import "SWStatus.h"

@implementation SWHomeStatusesResult
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [SWStatus class]};
}
@end
