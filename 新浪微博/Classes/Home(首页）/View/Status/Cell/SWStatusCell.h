//
//  SWStatusCell.h
//  新浪微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 XC. All rights reserved.
//  微博cell

#import <UIKit/UIKit.h>
@class SWStatusFrame,SWStatusDetailView;
@interface SWStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SWStatusFrame *statusFrame;

@property (nonatomic, weak) SWStatusDetailView *detailView;

@end
