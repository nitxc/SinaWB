//
//  SWGeneralSettingViewController.m
//  新浪微博
//
//  Created by apple on 15-3-15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWGeneralSettingViewController.h"
#import "SWCommonGroup.h"
#import "SWCommonItem.h"
#import "SWCommonArrowItem.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonLabelItem.h"

@interface SWGeneralSettingViewController ()

@end

@implementation SWGeneralSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
}

/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonLabelItem *readMdoe = [SWCommonLabelItem itemWithTitle:@"阅读模式"];
    readMdoe.text = @"有图模式";
    
    group.items = @[readMdoe];
}

- (void)setupGroup1
{
    
}

- (void)setupGroup2
{
    
}
@end
