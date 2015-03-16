//
//  DiscoverViewController.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWDiscoverViewController.h"
#import "SWSearchBar.h"
#import "SWCommonGroup.h"
#import "SWCommonItem.h"
#import "SWCommonCell.h"
#import "SWCommonArrowItem.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonLabelItem.h"
#import "SWOneViewController.h"
@interface SWDiscoverViewController ()

@end

@implementation SWDiscoverViewController



- (void)setupSearchBar
{
    
    
    SWSearchBar *searchBar = [SWSearchBar searchBar];
    searchBar.width = [UIScreen mainScreen].bounds.size.width-20;
    searchBar.height =32;
    searchBar.placeholder = @"大家都在搜：男模遭趴光";
    
    [self navigationItem].titleView = searchBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchBar];
  
    // 初始化模型数据
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
    
    // 2.设置组的基本数据

    
    // 3.设置组的所有行数据
    SWCommonArrowItem *hotStatus = [SWCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    
    SWCommonArrowItem *findPeople = [SWCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.badgeValue = @"13";
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hotStatus, findPeople];
}

- (void)setupGroup1
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据:根据不同cell下那是不同内容
    SWCommonItem *gameCenter = [SWCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameCenter.destVcClass = [SWOneViewController class];

    SWCommonLabelItem *near = [SWCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
    near.text = @"测试文字";
    near.destVcClass = [SWOneViewController class];
    SWCommonSwitchItem *app = [SWCommonSwitchItem itemWithTitle:@"应用" icon:@"app"];
    app.badgeValue = @"10";
    app.destVcClass = [SWOneViewController class];
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonSwitchItem *video = [SWCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
    video.operation = ^{
        SWLog(@"----点击了视频---");
    };
    SWCommonSwitchItem *music = [SWCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
   
    SWCommonItem *movie = [SWCommonItem itemWithTitle:@"电影" icon:@"movie"];
    movie.operation = ^{
        SWLog(@"----点击了电影");
    };
    SWCommonLabelItem *cast = [SWCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
    cast.operation = ^{
        SWLog(@"----点击了播客");
    };
    cast.badgeValue = @"5";
    cast.subtitle = @"(10)";
    cast.text = @"axxxx";
    SWCommonArrowItem *more = [SWCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    //    more.badgeValue = @"998";
    
    group.items = @[video, music, movie, cast, more];
}

@end
