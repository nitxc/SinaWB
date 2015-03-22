//
//  SWCommentCell.m
//  新浪微博
//
//  Created by xc on 15/3/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWCommentCell.h"
#import "SWCommentLable.h"
#import "SWComment.h"
#import "SWUser.h"
#import "UIImageView+WebCache.h"
@interface SWCommentCell()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UIImageView *vipView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic,weak) SWCommentLable *textCommentLabel;

@property (nonatomic,weak) UIView *divderView;
@end

@implementation SWCommentCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CommentCell";
    SWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SWCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件
        // 1.添加微博具体内容
        [self setupCommentView];

        
        // 2.增加一个分割线
        UIView *divderView =[[UIView alloc] init];
        divderView.backgroundColor = [UIColor blackColor];
        divderView.alpha = 0.2;
        [self addSubview:divderView];
        self.divderView = divderView;
        
    }
    return self;
}
- (void) setupCommentView
{
    //1.增加头像
    // 1.昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = SWCommentUserNameFont;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 2.正文（内容）
    SWCommentLable *commentTextLabel = [[SWCommentLable alloc] init];
    // textLabel.font = SWStatusOriginalTextFont;
    //设置时间类型
    commentTextLabel.noticationType = SWBaseLableEventNoticationTypeComment;
    [self addSubview:commentTextLabel];
    self.textCommentLabel = commentTextLabel;
    
    // 3.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = SWCommentTimeColor;

    timeLabel.font = SWCommentTimeFont;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 4.头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 5.会员图标
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self addSubview:vipView];
    self.vipView = vipView;

}

- (void)setCommentFrame:(SWCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    //设置头像的frame和图片
    
    //取出评论数据
    
    SWComment *comment = commentFrame.comment;
    //用户
    SWUser *user = comment.user;
    //设置昵称和是否显示会员等级
    self.nameLabel.text = user.name;
    self.nameLabel.frame = commentFrame.nameFrame;
    if (user.isVip) { // 会员
        self.nameLabel.textColor = SWColor(242, 112, 101);
        self.vipView.hidden = NO;
        self.vipView.frame = commentFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 2.正文（内容）
    self.textCommentLabel.attributedText = comment.attributedText;
   
    self.textCommentLabel.frame =commentFrame.textFrame;
   
    // 3.时间
    
    self.timeLabel.text = comment.created_at;
    self.timeLabel.frame = commentFrame.timeFrame;
   
  

    // 4.头像
    self.iconView.frame = commentFrame.iconFrame;
    // 需要自定义一个imageview verified:1-验证  分为企业和用户  verified_type 3 表示企业
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    // 5.设置分割线的位置
    self.divderView.frame = CGRectMake(0, commentFrame.cellHeight -0.6, SWScreenWidth, 0.6);
       
}
@end
