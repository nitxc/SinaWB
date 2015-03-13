//
//  DiscoverViewController.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWDiscoverViewController.h"
#import "SWSearchBar.h"
@interface SWDiscoverViewController ()

@end

@implementation SWDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SWSearchBar *searchBar = [SWSearchBar searchBar];
    searchBar.width = [UIScreen mainScreen].bounds.size.width-20;
    searchBar.height =32;
    searchBar.placeholder = @"大家都在搜：男模遭趴光";

    [self navigationItem].titleView = searchBar;
  
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
