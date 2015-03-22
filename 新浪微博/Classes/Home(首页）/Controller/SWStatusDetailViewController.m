//
//  SWStatusDetailController.m
//  新浪微博
//
//  Created by xc on 15/3/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWStatusDetailViewController.h"
#import "SWStatusDetailView.h"
#import "SWStatusDetailFrame.h"
#import "SWStatus.h"
#import "SWStatusDetailBottomToolbar.h"
#import "SWStatusDetailTopToolbar.h"
#import "SWComment.h"
#import "SWStatusTool.h"
#import "SWCommentFrame.h"
#import "SWCommentCell.h"
@interface SWStatusDetailViewController()<UITableViewDataSource, UITableViewDelegate, SWStatusDetailTopToolbarDelegate>

@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic, strong) SWStatusDetailTopToolbar *topToolbar;
@property (nonatomic, strong) NSMutableArray *commentsFrame;
@property (nonatomic, strong) NSMutableArray *reposts;
@end

@implementation SWStatusDetailViewController

- (NSMutableArray *)commentsFrame
{
    if (_commentsFrame == nil) {
        self.commentsFrame = [NSMutableArray array];
    }
    return _commentsFrame;
}

- (NSMutableArray *)reposts
{
    if (_reposts == nil) {
        self.reposts = [NSMutableArray array];
    }
    return _reposts;
}

- (SWStatusDetailTopToolbar *)topToolbar
{
    if (!_topToolbar) {
        self.topToolbar = [SWStatusDetailTopToolbar toolbar];
        self.topToolbar.status = self.status;
        self.topToolbar.delegate = self;
    }
    return _topToolbar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1 设置导航显示标题
    self.title = @"微博正文";
    
    //2 创建一个tabview
    [self setupTableView];
    
    //3 设置微博详细内容
    [self setupStatusDetailView];
    
    //4 创建一个底部的toolbar
    
    [self setupStatusDetailBottomToolBar];

    
}


- (void)setupStatusDetailBottomToolBar
{
    SWStatusDetailBottomToolbar *bootomToolbar = [[SWStatusDetailBottomToolbar alloc] init];
    bootomToolbar.backgroundColor = SWGobleTableViewBackgroundColor;
    bootomToolbar.x = 0;
    bootomToolbar.y = self.tableView.height;
    bootomToolbar.width = self.view.width;
    bootomToolbar.height  = 47;
    [self.view addSubview:bootomToolbar];
    
}
/**
 *  设置tableview
 */
- (void) setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = SWGobleTableViewBackgroundColor;
    tableView.width = self.view.width;
    tableView.height  = self.view.height-47;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.view addSubview:tableView];
    self.tableView = tableView;
}
/**
 *  设置微博详细内容
 */
- (void) setupStatusDetailView
{
    //1. 创建微博详细内容view
    SWStatusDetailView *statusDetailView = [[SWStatusDetailView alloc] init];
    //2. 设置微博详细内容的frame
    SWStatusDetailFrame *statusFrame = [[SWStatusDetailFrame alloc] init];
    //3. 设置一个标志是显示正文的标志
    self.status.retweeted_status.detailContent = YES;
    self.status.detailContent = YES;

    statusFrame.status = self.status;
    
    statusDetailView.detailFrame = statusFrame;
    //4. 设置微博详情的高度
    statusDetailView.height = statusFrame.frame.size.height;
    self.tableView.tableHeaderView = statusDetailView;
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.topToolbar.selectedButtonType == SWStatusDetailTopToolbarButtonTypeComment) {
        return self.commentsFrame.count;
    } else {
        return self.reposts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //需要自定义cell
     if (self.topToolbar.selectedButtonType == SWStatusDetailTopToolbarButtonTypeComment) {
         SWCommentCell *cell = [SWCommentCell cellWithTableView:tableView];
         cell.commentFrame = self.commentsFrame[indexPath.row];
        return cell;
    } else {
        //转发
        
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 取出当前模型frame数据
    SWCommentFrame *comentFrame = self.commentsFrame[indexPath.row];
    
    return comentFrame.cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topToolbar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.topToolbar.height;
}

#pragma mark - 顶部工具条的代理
- (void)topToolbar:(SWStatusDetailTopToolbar *)topToolbar didSelectedButton:(SWStatusDetailTopToolbarButtonType)buttonType
{
    [self.tableView reloadData];
    switch (buttonType) {
        case SWStatusDetailTopToolbarButtonTypeComment: // 评论
            [self loadComments];
            break;
            
        case SWStatusDetailTopToolbarButtonTypeRetweeted: // 转发
            [self loadRetweeteds];
            break;
    }
}

-(NSArray *)commentsFramesWithComments:(NSArray *) comments
{
    NSMutableArray *frames = [NSMutableArray array];
    for (SWComment *comment in comments) {
        SWCommentFrame *frame = [[SWCommentFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.comment = comment;
        [frames addObject:frame];
    }
    return frames;
}

/**
 *  加载评论数据
 */
- (void)loadComments
{
    SWCommentsParam *param = [SWCommentsParam param];
    param.id = self.status.idstr;
    SWCommentFrame *commentFrame = [self.commentsFrame firstObject];
    SWComment *cmt = commentFrame.comment;
    param.since_id = cmt.idstr;
    
    [SWStatusTool commentsWithParam:param success:^(SWCommentsResult *result) {
        // 评论总数
        self.status.comments_count = result.total_number;
        self.topToolbar.status = self.status;
        // 获得最新的微博frame数组
        NSArray *newFrames = [self commentsFramesWithComments:result.comments];
        // 累加评论数据
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
        [self.commentsFrame insertObjects:newFrames atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  加载转发数据
 */
- (void)loadRetweeteds
{
    SWRepostsParam *param = [SWRepostsParam param];
    param.id = self.status.idstr;
    SWStatus *status = [self.reposts firstObject];
    param.since_id = status.idstr;
    
    [SWStatusTool repostsWithParam:param success:^(SWRepostsResult *result) {
        // 转发总数
        self.status.reposts_count = result.total_number;
        self.topToolbar.status = self.status;
        
        // 累加评论数据
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.reposts.count)];
        [self.reposts insertObjects:result.reposts atIndexes:set];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

@end
