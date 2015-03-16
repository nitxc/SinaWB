//
//  HMCommonItem.m
//  黑马微博
//
//  Created by apple on 14-7-21.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWCommonItem.h"

@implementation SWCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    SWCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
