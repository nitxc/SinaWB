//
//  SWTabBarController.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWTabBarController.h"
#import "SWHomeViewController.h"
#import "SWMessageViewController.h"
#import "SWDiscoverViewController.h"
#import "SWProfileViewController.h"
#import "SWNavigationController.h"
#import "SWTabBar.h"
#import "SWComposeViewController.h"
#import "SWAccountTool.h"
#import "SWAccount.h"
#import "SWUserTool.h"
#import "SWUnreadCountParam.h"
@interface SWTabBarController ()<SWTabBarDelegate>

@property(nonatomic,weak)SWHomeViewController *homeViewController;
@property(nonatomic,weak)SWMessageViewController *messageViewController;
@property(nonatomic,weak)SWProfileViewController *profileViewConreoller;

@end

@implementation SWTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1. 添加所有的子控制器
    [self addAllChildVcs];
    
    // 2. 创建自定义tabbar
    [self addCustomTabBar];
    // 3. 设置用户信息未读数
    // 利用定时器获得用户的未读数
    
    //刚开始先调用一次
    [self getUnreadCount];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void) getUnreadCount
{
    //1. 封装参数
    SWUnreadCountParam *unreadCountParams = [[SWUnreadCountParam alloc] init];
    unreadCountParams.uid = [SWAccountTool account].uid;
    
    [SWUserTool unreadCountWithParam:unreadCountParams success:^(SWUnreadCountResult *result) {
        // 显示微博未读数
        if (result.status == 0) {
            self.homeViewController.tabBarItem.badgeValue = nil;
        } else {
            self.homeViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.messageViewController.tabBarItem.badgeValue = nil;
        } else {
            self.messageViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profileViewConreoller.tabBarItem.badgeValue = nil;
        } else {
            self.profileViewConreoller.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        // 在图标上显示所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;


    } failure:^(NSError *error) {
        SWLog(@"获取用户未读数据失败");
    }];
    
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    SWTabBar *customTabBar = [[SWTabBar alloc] init];
    customTabBar.tarbarDelegate = self;
    
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}
/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    
    SWHomeViewController *home = [[SWHomeViewController alloc] init];
    [self addOneChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    _homeViewController = home;
    SWMessageViewController *message = [[SWMessageViewController alloc] init];
    [self addOneChlildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    _messageViewController = message;
    SWDiscoverViewController *discover = [[SWDiscoverViewController alloc] init];
    [self addOneChlildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    SWProfileViewController *profile = [[SWProfileViewController alloc] init];
    [self addOneChlildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    _profileViewConreoller = profile;
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //childVc.view.backgroundColor = HMRandomColor;
    // 设置标题
    childVc.title = title;
    if ([childVc class] == [SWDiscoverViewController class]) {
        childVc.navigationItem.title = @"微博";
    }
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加导航控制器
    SWNavigationController *nav = [[SWNavigationController alloc] initWithRootViewController:childVc];
    
    // 添加为tabbar控制器的子控制器
    [self addChildViewController:nav];
    
    
}

// 在iOS7中, 会对selectedImage的图片进行再次渲染为蓝色
// 要想显示原图, 就必须得告诉它: 不要渲染

// Xcode的插件安装路径: /Users/用户名/Library/Application Support/Developer/Shared/Xcode/Plug-ins

/**
 *  默认只调用该功能一次
 */

+ (void)initialize
{
    //设置底部tabbar的主题样式
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:SWCommonColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - HMTabBarDelegate
- (void)tabBarDidClickedPlusButton:(SWTabBar *)tabBar
{
    // 弹出发微博控制器
    SWComposeViewController *compose = [[SWComposeViewController alloc] init];
    SWNavigationController *nav = [[SWNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
