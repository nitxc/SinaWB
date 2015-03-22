//
//  SWCommentCell.h
//  新浪微博
//
//  Created by xc on 15/3/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWCommentFrame.h"
@interface SWCommentCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SWCommentFrame *commentFrame;
@end
