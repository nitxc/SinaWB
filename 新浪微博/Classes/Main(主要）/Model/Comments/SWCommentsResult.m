//
//  SWCommentsResult.m
//  新浪微博
//
//  Created by apple on 15-3-25.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWCommentsResult.h"
#import "MJExtension.h"
#import "SWComment.h"

@implementation SWCommentsResult
- (NSDictionary *)objectClassInArray
{
    return @{@"comments" : [SWComment class]};
}
@end
