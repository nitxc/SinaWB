//
//  SWProfileViewController.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWProfileViewController.h"
#import "SWSystemSettingController.h"
@interface SWProfileViewController ()
@property (nonatomic,assign,getter=isLogin) NSString *login;
@end

@implementation SWProfileViewController
// 懒加载判断是否登录
- (NSString *)isLogin
{
    if (_login==nil) {
        //需要判断当前是否登录
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *loginFlag = [defaults objectForKey:@"loginFlag"];
        if (loginFlag == nil) {
            _login = @"false";
        }else{
            _login = @"true";
        }
        
    }
    return _login;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //校验是否登录：未登录，需要显示登录注册
    
    [self setupNavgationItem];
}


/**
 *  设置当前控制器的导航显示item
 */
- (void)setupNavgationItem
{
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    if ([self.login isEqualToString:@"true"]) {//登录
      
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"添加好友" style:UIBarButtonItemStyleDone target:self action:@selector(addFreinds)];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setting
{
    SWSystemSettingController *systemSetting = [[SWSystemSettingController alloc] init];
    
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
