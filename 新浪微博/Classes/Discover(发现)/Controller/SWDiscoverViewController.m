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
@interface SWDiscoverViewController ()
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation SWDiscoverViewController
- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}
/** 屏蔽tableView的样式 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}


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
    // 设置tableView属性
    self.tableView.backgroundColor = SWGobleTableViewBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = SWStatusCellMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(SWStatusCellMargin - 35, 0, 0, 0);
    
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
    
    // 2.设置组的所有行数据
    SWCommonItem *gameCenter = [SWCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    
    SWCommonLabelItem *near = [SWCommonLabelItem itemWithTitle:@"周边" icon:@"near"];
    near.text = @"测试文字";
    
    SWCommonSwitchItem *app = [SWCommonSwitchItem itemWithTitle:@"应用" icon:@"app"];
    app.badgeValue = @"10";
    
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonSwitchItem *video = [SWCommonSwitchItem itemWithTitle:@"视频" icon:@"video"];
    SWCommonSwitchItem *music = [SWCommonSwitchItem itemWithTitle:@"音乐" icon:@"music"];
    SWCommonItem *movie = [SWCommonItem itemWithTitle:@"电影" icon:@"movie"];
    SWCommonLabelItem *cast = [SWCommonLabelItem itemWithTitle:@"播客" icon:@"cast"];
    cast.badgeValue = @"5";
    cast.subtitle = @"(10)";
    cast.text = @"axxxx";
    SWCommonArrowItem *more = [SWCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    //    more.badgeValue = @"998";
    
    group.items = @[video, music, movie, cast, more];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SWCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWCommonCell *cell = [SWCommonCell cellWithTableView:tableView];
    SWCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:(int)group.items.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
