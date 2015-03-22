//
//  SWProfileViewController.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWProfileViewController.h"
#import "SWSettingViewController.h"
#import "SWCommonGroup.h"
#import "SWCommonItem.h"
#import "SWCommonArrowItem.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonLabelItem.h"
@interface SWProfileViewController ()
@property (nonatomic,assign,getter=isLogin) NSString *login;
@end

@implementation SWProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //校验是否登录：未登录，需要显示登录注册
    
    [self setupNavgationItem];
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
}
/**
 *  设置当前控制器的导航显示item
 */
- (void)setupNavgationItem
{
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"添加好友" style:UIBarButtonItemStyleDone target:self action:@selector(addFreinds)];
   
    
}

- (void)setupGroup0
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonArrowItem *newFriend = [SWCommonArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
    newFriend.badgeValue = @"5";
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonArrowItem *album = [SWCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    
    SWCommonArrowItem *collect = [SWCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subtitle = @"(10)";
    collect.badgeValue = @"1";
    
    SWCommonArrowItem *like = [SWCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
    like.badgeValue = @"10";
    
    group.items = @[album, collect, like];
}



- (void)setting
{
    SWSettingViewController *systemSetting = [[SWSettingViewController alloc] init];
    
    [self.navigationController pushViewController:systemSetting animated:YES];
    
}

- (void)addFreinds
{
    SWLog(@"添加好友");
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
