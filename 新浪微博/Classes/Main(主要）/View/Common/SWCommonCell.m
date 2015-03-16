//
//  SWCommonCell.m
//  新浪微博
//
//  Created by apple on 15-3-15.
//  Copyright (c) 2015年 xc. All rights reserved.
//


#import "SWCommonCell.h"
#import "SWCommonItem.h"
#import "SWCommonArrowItem.h"
#import "SWCommonSwitchItem.h"
#import "SWCommonLabelItem.h"
#import "SWBadgeView.h"

@interface SWCommonCell()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;
/**
 *  提醒数字
 */
@property (strong, nonatomic) SWBadgeView *bageView;
@end

@implementation SWCommonCell

#pragma mark - 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

- (SWBadgeView *)bageView
{
    if (_bageView == nil) {
        self.bageView = [[SWBadgeView alloc] init];
    }
    return _bageView;
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    SWCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SWCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        
    }
    return self;
}

#pragma mark - 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}
#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows
{
    // 1.取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
  
    if (rows == 1) {
        bgView.image = [UIImage resizableImageWithName:@"common_card_background"];
        selectedBgView.image = [UIImage resizableImageWithName:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage resizableImageWithName:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizableImageWithName:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizableImageWithName:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizableImageWithName:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizableImageWithName:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizableImageWithName:@"common_card_middle_background_highlighted"];
    }
}

- (void)setItem:(SWCommonItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    // 2.设置右边的内容
    if (item.badgeValue) { // 紧急情况：右边有提醒数字
        self.bageView.badgeValue = item.badgeValue;
        self.accessoryView = self.bageView;
    } else if ([item isKindOfClass:[SWCommonArrowItem class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[SWCommonSwitchItem class]]) {
        self.accessoryView = self.rightSwitch;
    } else if ([item isKindOfClass:[SWCommonLabelItem class]]) {
        SWCommonLabelItem *labelItem = (SWCommonLabelItem *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.accessoryView = self.rightLabel;
    } else { // 取消右边的内容
        self.accessoryView = nil;
    }
}
@end
