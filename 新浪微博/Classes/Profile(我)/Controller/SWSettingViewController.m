//
//  SWSettingViewController.m
//  新浪微博
//
//  Created by apple on 15-3-21.
//  Copyright (c) 2015年 xc. All rights reserved.
//
#import "SWSettingViewController.h"
#import "SWCommonGroup.h"
#import "SWCommonItem.h"
#import "SWCommonArrowItem.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonLabelItem.h"
#import "SWGeneralSettingViewController.h"

@interface SWSettingViewController ()

@end

@implementation SWSettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroups];
    
    [self setupFooter];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:SWColor(255, 10, 10) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizableImageWithName:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizableImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
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
    group.footer = @"tail部";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonArrowItem *newFriend = [SWCommonArrowItem itemWithTitle:@"帐号管理"];
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonArrowItem *newFriend = [SWCommonArrowItem itemWithTitle:@"主题、背景"];
    
    group.items = @[newFriend];
}

- (void)setupGroup2
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    group.header = @"头部";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonArrowItem *generalSetting = [SWCommonArrowItem itemWithTitle:@"通用设置"];
    generalSetting.destVcClass = [SWGeneralSettingViewController class];
    
    group.items = @[generalSetting];
}
@end
