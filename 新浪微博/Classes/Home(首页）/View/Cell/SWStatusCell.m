//
//  HMStatusCell.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWStatusCell.h"
#import "SWStatusDetailView.h"
#import "SWStatusToolbar.h"
#import "SWStatusFrame.h"
#import "SWStatusDetailFrame.h"
@interface SWStatusCell()
@property (nonatomic, weak) SWStatusToolbar *toolbar;
@end

@implementation SWStatusCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"statusCell";
    SWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件
        // 1.添加微博具体内容
        [self setupDetailView];
        
        // 2.添加工具条
        [self setupToolbar];
        
        // 3.cell的设置
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

/**
 *  添加微博具体内容
 */
- (void)setupDetailView
{
    SWStatusDetailView *detailView = [[SWStatusDetailView alloc] init];
    [self.contentView addSubview:detailView];
    self.detailView = detailView;
}

/**
 *  添加工具条
 */
- (void)setupToolbar
{
    SWStatusToolbar *toolbar = [[SWStatusToolbar alloc] init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}
- (void)setStatusFrame:(SWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
  
    
    // 1.设置详情frame数据
    self.detailView.detailFrame = statusFrame.statusDetailFrame;
    
    // 2.底部工具条的frame数据
    self.toolbar.frame = statusFrame.statusToolbarFrame;
    // 3.设置底部工具天需要的模型数据
    self.toolbar.status =statusFrame.status;
    
}
@end
