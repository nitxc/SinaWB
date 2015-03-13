//
//  SWHomeViewController.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//
/**
 44 : cell的默认高度、导航栏的可见高度
 49 : UITabBar的默认高度
 64 : 从窗口顶部到导航栏底部
 20 : 状态栏高度
 320 : 竖屏情况下的屏幕宽度
 480 : 竖屏情况下的3.5 inch 的屏幕高度
 568 : 竖屏情况下的4.0 inch 的屏幕高度
 */
#import "SWHomeViewController.h"
#import "SWTitleButton.h"
#import "SWPopMenu.h"
#import "SWAccountTool.h"
#import "SWAccount.h"
#import "SWStatus.h"
#import "MJExtension.h"
#import "SWUser.h"
#import "UIImageView+WebCache.h"
#import "SWLoadMoreFooter.h"
#import "SWUserTool.h"
#import "SWUserInfoResult.h"
#import "SWStatusTool.h"
#import "SWStatusFrame.h"
#import "SWStatusCell.h"
#import "SWStatusOriginalView.h"
#import "SWStatusDetailView.h"
@interface SWHomeViewController ()<SWStatusOriginalViewDelegate,UIActionSheetDelegate>
/**
 *  微博数组(存放着所有的微博数据)
 */
@property (nonatomic, strong) NSMutableArray *statusesFrame;

@property (nonatomic, weak) SWLoadMoreFooter *footer;
@property (nonatomic, weak) SWTitleButton *titleButton;

@end


@implementation SWHomeViewController

- (NSMutableArray *)statusesFrame
{
    if (_statusesFrame == nil) {
        _statusesFrame = [NSMutableArray array];
    }
    return _statusesFrame;
}
- (void)setupCenterTitle
{
   
    //创建导航中间标题按钮
    SWTitleButton *titleButton = [[SWTitleButton alloc] init];
    titleButton.height = SWNavigationItemOfTitleViewHeight;
    // 设置文字
    [titleButton setTitle:[SWAccountTool account].userName?[SWAccountTool account].userName:@"首页" forState:UIControlStateNormal];
    // 设置图标
    UIImage *mainImage = [[UIImage imageWithName:@"main_badge"] scaleImageWithSize:CGSizeMake(10, 10)];
    
    [titleButton setImage:mainImage forState:UIControlStateNormal];
    // 设置背景
    [titleButton setBackgroundImage:[UIImage resizableImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    self.navigationItem.titleView =titleButton;
    // 监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    // 获取用户信息
    [self setupUserInfo];
    
    
}
/**
 *  获取用户信息
 */
- (void)setupUserInfo
{
    // 1.封装请求参数

    SWAccount *account = [SWAccountTool account];
    SWUserInfoParam *userInfoParam = [SWUserInfoParam param];
    userInfoParam.uid =account.uid;
  
    // 2.加载用户信息
    [SWUserTool userInfoWithParam:userInfoParam success:^(SWUserInfoResult *user) {
        
        [_titleButton setTitle:user.name forState:UIControlStateNormal];
        // 存储帐号信息
        SWAccount *account = [SWAccountTool account];
        account.userName = user.name;
        [SWAccountTool save:account];
        
    } failure:^(NSError *error) {
        SWLog(@"获取用户昵称失败");
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1 设置导航按钮并获取用户标题
    [self setupNavgationItem];
    //2 删除分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //3 集成刷新控件
    [self setupRefresh];
    
    self.tableView.backgroundColor = SWColor(239, 239, 239);

  
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    
    // 2.监听状态
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControl beginRefreshing];
    
    // 4.加载数据
    [self refreshControlStateChange:refreshControl];
    
    // 5.添加上拉加载更多控件
    SWLoadMoreFooter *footer = [SWLoadMoreFooter footer];
    self.tableView.tableFooterView = footer;
    self.footer = footer;
    
}
/**
 *  当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void) refreshControlStateChange:(UIRefreshControl *)refreshControl
{
   
    [self loadNewStatuses:refreshControl];
   
    
}
/**
 *  根据微博模型数组 转成 微博frame模型数据
 *
 *  @param statuses 微博模型数组
 *
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (SWStatus *status in statuses) {
        SWStatusFrame *frame = [[SWStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

#pragma mark - 加载微博数据
/**
 *  加载最新的微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    
    // 1.封装请求参数
    SWHomeStatusesParam *param = [SWHomeStatusesParam param];
    SWStatusFrame *firstStatusFrame =  [self.statusesFrame firstObject];
    SWStatus *firstStatus = firstStatusFrame.status;
    if (firstStatus) {
        // since_id 	false 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        param.since_id = @([firstStatus.idstr longLongValue]);;
    }
    // 2.加载微博数据
    
    [SWStatusTool homeStatusesWithParam:param success:^(SWHomeStatusesResult *result) {
        // 获得最新的微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];

        
        // 将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrame insertObjects:newFrames atIndexes:indexSet];
        // 重新刷新表格
        [self.tableView reloadData];
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        
        // 提示用户最新的微博数量
        [self showNewStatusesCount:(int)newFrames.count];
        
        //首页图标数据清零
        [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.intValue;

        self.tabBarItem.badgeValue = nil;
        
    } failure:^(NSError *error) {
        SWLog(@"请求失败--%@", error);

    }];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
    // 1.封装请求参数
    SWHomeStatusesParam *param = [SWHomeStatusesParam param];
    SWStatusFrame *lastStatusFrame =  [self.statusesFrame lastObject];
    SWStatus *lastStatus = lastStatusFrame.status;
    
    if (lastStatus) {
        // since_id 	false 	int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        param.max_id = @([lastStatus.idstr longLongValue]);;
    }
   
    
    // 3.发送GET请求
    [SWStatusTool homeStatusesWithParam:param success:^(SWHomeStatusesResult *result) {
        // 获得最新的微博数组
        // 获得最新的微博frame数组
        NSArray *newFrames = [self statusFramesWithStatuses:result.statuses];
        
        // 将新数据插入到旧数据的最后面
        [self.statusesFrame addObjectsFromArray:newFrames];
        
        // 重新刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        SWLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [self.footer endRefreshing];
    }];
}

/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];

    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    } else {
        label.text = @"没有最新的微博数据";
    }
    
    // 3.设置背景
    label.backgroundColor = SWCommonColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width = self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = SWNavigationHeight - label.height;
    
    // 5.添加到导航控制器的view
    //    [self.navigationController.view addSubview:label];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    //    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        //        label.alpha = 1.0;
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
            //            label.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}
/**
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // 开始：由慢到快，结束：由快到慢
 UIViewAnimationOptionCurveEaseIn               = 1 << 16, // 由慢到块
 UIViewAnimationOptionCurveEaseOut              = 2 << 16, // 由快到慢
 UIViewAnimationOptionCurveLinear               = 3 << 16, // 线性，匀速
 */
/**
 *  设置当前控制器的导航显示item
 */
- (void)setupNavgationItem
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"navigationbar_friendsearch" highBackgroudImageName:@"navigationbar_friendsearch_highlighted"  target:self action:@selector(friendsearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"navigationbar_pop" highBackgroudImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    //设置导航中间标题
    [self setupCenterTitle];
    
    
    
    
}

/**
 *  点击标题点击
 */
- (void)titleClick:(UIButton *)titleButton
{
    
    
    // 弹出菜单
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    SWPopMenu *menu = [[SWPopMenu alloc ] initWithContentView:button];
    menu.arrowPosition = HMPopMenuArrowPositionCenter;
    //menu.dimBackground = YES;//是否添加蒙版
    [menu showInRect:CGRectMake((self.view.frame.size.width-217)/2.0,CGRectGetMaxY([self.navigationController navigationBar].frame)-SWPopMenuMarginTop, 217, 400)];
    
}
/**
 *  返回加载微博的数量
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //未有数据不展示底部加载更多数据
    self.footer.hidden = self.statusesFrame.count == 0;
    return _statusesFrame.count;
}

/**
 *  cell 显示具体内容
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建自定义cell
    SWStatusCell * cell = [SWStatusCell cellWithTableView:tableView];
    //2.传递模型frame数据
    cell.statusFrame = _statusesFrame[indexPath.row];
    
    cell.detailView.originalView.delegate = self;

    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 取出当前模型frame数据
    SWStatusFrame *statusFrame = self.statusesFrame[indexPath.row];
    
    return statusFrame.cellHeight;
}

/**
 *  控制选中某行的数据展示方法
 *
 *  @param tableView
 *  @param indexPath
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newVc = [[UIViewController alloc] init];
    newVc.view.backgroundColor = [UIColor redColor];
    newVc.title = @"新控制器";
    [self.navigationController pushViewController:newVc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusesFrame.count <= 0 || self.footer.isRefreshing) return;
    
    // 1.差距
    CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
    // 刚好能完整看到footer的高度
    CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
    
    // 2.如果能看见整个footer
    if (delta <= (sawFooterH - 0)) {
        // 进入上拉刷新状态
        [self.footer beginRefreshing];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载更多的微博数据
            [self loadMoreStatuses];
        });
    }
}
- (void)pop
{
    SWLog(@"--扫一扫--");
}
- (void)friendsearch
{
    SWLog(@"--好友搜索--");
}
/**
 *  更多按钮点击效果
 *
 *  @param statusOriginalView
 */
- (void)statusOriginalViewDidClickedMoreButton:(SWStatusOriginalView *)statusOriginalView
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报",@"屏蔽",@"取消关注",@"收藏", nil];
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SWLog(@"---点击按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
