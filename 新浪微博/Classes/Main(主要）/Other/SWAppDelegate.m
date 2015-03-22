//
//  AppDelegate.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWAppDelegate.h"
#import "SWOAuthViewController.h"
#import "SWAccount.h"
#import "SWAccountTool.h"
#import "SWControllerTool.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "MBProgressHUD+MJ.h"
#import "SWHttpTool.h"
@interface SWAppDelegate ()

@end

@implementation SWAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    application.statusBarHidden = NO;//启动成功以后不隐藏状态栏
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    // 2.显示窗口(成为主窗口)
    [self.window makeKeyAndVisible];
    // 3.设置窗口的根控制器
    SWAccount *account = [SWAccountTool account];
    if (account) {
        [SWControllerTool chooseRootViewController];
    } else { // 没有登录过
        self.window.rootViewController = [[SWOAuthViewController alloc] init];
    }
    
    // 4.监控网络
    [SWHttpTool monitoringReachabilityStatus:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                //SWLog(@"没有网络(断网)");
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                //SWLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                //SWLog(@"WIFI");
                break;
        }
    }];
    
    // 5.增加网络状态激活按钮
    [SWHttpTool showNetworkActivityIndicator];

    // 6.对于大于ios8.1的系统需要注册用户协议通知才能实现applicationIconBadgeNumber
    
#if __IPHONE_8_1
    if(IOS8){
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        

    }else{
          [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    }
   
#else
    
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    [application registerForRemoteNotificationTypes:myTypes];
    
#endif
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    __block UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:taskID];
    }];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/**
 *  内存警告时：及时清除图片内存
 *
 *  @param application <#application description#>
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 赶紧清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}
@end
