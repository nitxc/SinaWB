//
//  SWBaseParam.m
//  新浪微博
//
//  Created by xc on 15/3/10.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWBaseParam.h"
#import "SWAccount.h"
#import "SWAccountTool.h"
@implementation SWBaseParam

- (instancetype)init
{
    if (self = [super init]) {
        self.access_token = [SWAccountTool account].access_token;
    }
    return self;
}

+(instancetype)param
{
    return [[self alloc] init];
}
@end
