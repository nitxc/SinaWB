//
//  SWBaseToolbar.m
//  新浪微博
//
//  Created by xc on 15/3/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWBaseToolbar.h"
#import "SWStatus.h"

@interface SWBaseToolbar()
@property (nonatomic, weak) UIButton *repostsBtn;
@property (nonatomic, weak) UIButton *commentsBtn;
@property (nonatomic, weak) UIButton *attitudesBtn;
@end

@implementation SWBaseToolbar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//子类想要实现自己颜色
        self.repostsBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        self.commentsBtn = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        self.attitudesBtn =[self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
    
        
    }
    return self;
}
/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
   
    // 设置高亮时的背景

    [btn setBackgroundImage:[UIImage resizableImageWithName:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = (int)self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = 0;
        btn.x = i * btnW;
    }
}


- (void)setStatus:(SWStatus *)status
{
    _status = status;
    
    
    [self setupBtnTitle:self.repostsBtn count:status.reposts_count defaultTitle:@"转发"];
    [self setupBtnTitle:self.commentsBtn count:status.comments_count defaultTitle:@"评论"];
    [self setupBtnTitle:self.attitudesBtn count:status.attitudes_count defaultTitle:@"赞"];
}

/**
 *  设置按钮的文字
 *
 *  @param button       需要设置文字的按钮
 *  @param count        按钮显示的数字
 *  @param defaultTitle 数字为0时显示的默认文字
 */
- (void)setupBtnTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%d", count];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}
/**
 1.小于1W ： 具体数字，比如9800，就显示9800
 2.大于等于1W：xx.x万，比如78985，就显示7.9万
 3.整W：xx万，比如800365，就显示80万
 **/


@end
