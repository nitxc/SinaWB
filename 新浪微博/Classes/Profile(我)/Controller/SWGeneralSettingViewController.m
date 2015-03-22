//
//  SWGeneralSettingViewController.m
//  新浪微博
//
//  Created by apple on 15-3-21.
//  Copyright (c) 2015年 xc. All rights reserved.
//
#import "SWGeneralSettingViewController.h"
#import "SWCommonGroup.h"
#import "SWCommonItem.h"
#import "SWCommonArrowItem.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonLabelItem.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"

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
  
}

- (void)setupGroup0
{
    // 1.创建组
    SWCommonGroup *group = [SWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SWCommonLabelItem *readMode = [SWCommonLabelItem itemWithTitle:@"阅读模式"];
    readMode.text = @"有图模式";
    
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    long double cacheSizeM = cacheSize/(1000.0*1000.0);
    NSString *subTitle = [NSString stringWithFormat:@" 缓存大小(%.1LfM)",cacheSizeM];
    SWCommonLabelItem *clearCache = [SWCommonLabelItem itemWithTitle:@"清理缓存"];
    clearCache.subtitle = subTitle;
    NSString *imageCachePath = [SDImageCache sharedImageCache].diskCachePath;
    __weak typeof(clearCache) weakClearCache = clearCache;
    __weak typeof(self) weakVc = self;
    clearCache.operation = ^{
        [MBProgressHUD showMessage:@"正在清理缓存中..."];
        // 清除缓存
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:imageCachePath error:nil];
        
        // 设置subtitle
        weakClearCache.subtitle = nil;
        
        // 刷新表格
        [weakVc.tableView reloadData];
        

        
        [MBProgressHUD hideHUD];
    };
    group.items = @[readMode,clearCache];
}

@end
