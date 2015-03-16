//
//  SWOneViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWOneViewController.h"
#import "SWTwoViewController.h"

@interface SWOneViewController ()
- (IBAction)jumpTwo;

@end

@implementation SWOneViewController

- (IBAction)jumpTwo {
    SWTwoViewController *two = [[SWTwoViewController alloc] init];
    two.title = @"TwoVc";
    [self.navigationController pushViewController:two animated:YES];
}
@end
