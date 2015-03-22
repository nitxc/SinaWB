//
//  SWStatusOriginalView.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWStatusOriginalView.h"
#import "SWStatusOriginalFrame.h"
#import "SWStatus.h"
#import "SWUser.h"
#import "UIImageView+WebCache.h"
#import "SWStatusUserHeadView.h"
#import "SWStatusPhotosView.h"
#import "SWStatusOriginalFrame.h"
#import "SWStatusLable.h"
@interface SWStatusOriginalView()
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) SWStatusLable *textLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/** 头像 */
@property (nonatomic, weak) SWStatusUserHeadView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 更多图标 */
@property (nonatomic, weak) UIButton *moreBtn;
/** 图片相册 */
@property (nonatomic, weak) SWStatusPhotosView *photosView;
/** 收藏按钮 */
@property (nonatomic, weak) UIButton *collectBtn;


@end
@implementation SWStatusOriginalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //能与用户交互
        self.userInteractionEnabled = YES;
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = SWStatusOriginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        SWStatusLable *textLabel = [[SWStatusLable alloc] init];
       // textLabel.font = SWStatusOriginalTextFont;
        //设置时间类型
        textLabel.noticationType = SWBaseLableEventNoticationTypeStatus;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = SWColor(242, 153, 92);
        timeLabel.font = SWStatusOriginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = SWColor(113, 113, 113);
        sourceLabel.font = SWStatusOriginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        SWStatusUserHeadView *iconView = [[SWStatusUserHeadView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        // 7.添加一个显示更多的按钮
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
        [moreBtn setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
        [moreBtn addTarget:self action:@selector(moreBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        self.moreBtn = moreBtn;
        moreBtn.adjustsImageWhenDisabled = NO;
        [self addSubview:moreBtn];
        
        // 8.配图相册
        SWStatusPhotosView *photosView = [[SWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        
        // 9.添加微博正文收藏按钮
        UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectBtn setImage:[UIImage imageNamed:@"card_icon_favorite"] forState:UIControlStateNormal];
        [collectBtn setImage:[UIImage imageNamed:@"card_icon_favorite_highlighted"] forState:UIControlStateSelected];
        [collectBtn addTarget:self action:@selector(collectBtnBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        self.collectBtn = collectBtn;
        collectBtn.adjustsImageWhenDisabled = NO;
        [self addSubview:collectBtn];
    }
    return self;
}
- (void)collectBtnBtnOnClick
{
    if (self.collectBtn.selected) {
        self.collectBtn.selected = NO;
    }else{
        self.collectBtn.selected = YES;
    }
 }

- (void)setOriginalFrame:(SWStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    
    self.frame = originalFrame.frame;
    
    // 取出微博数据
    SWStatus *status = originalFrame.status;
    // 取出用户数据
    SWUser *user = status.user;
    // 1.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    if (user.isVip) { // 会员
        self.nameLabel.textColor = SWColor(242, 112, 101);
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 2.正文（内容）
    self.textLabel.attributedText = status.attributedText;
    self.textLabel.frame = originalFrame.textFrame;
    
   //warning 需要时刻根据现在的时间字符串来计算时间label的frame
    // 3.时间
    NSString *time = status.created_at;
    self.timeLabel.text = time; // 刚刚 --> 1分钟前 --> 10分钟前
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + SWStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithFont:SWStatusOriginalTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + SWStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SWStatusOriginalSourceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 5.头像
    self.iconView.frame = originalFrame.iconFrame;
    // 需要自定义一个imageview verified:1-验证  分为企业和用户  verified_type 3 表示企业
    [self.iconView addVIPImageWithVeritfied:user.verified verifiedType:user.verified_type];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
 
    
    // 7.配图相册
    if (status.pic_urls.count) { // 有配图
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.picUrls = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    // 8.收藏按钮
    if (status.detailContent) {
        self.collectBtn.frame = originalFrame.collectFrame;
    }else{
        // 6.更多按钮
        self.moreBtn.frame = originalFrame.moreFrame;

    }
    
}

/**
 *  更多按钮点击
 */
- (void)moreBtnOnClick
{
    //利用通知发送更多按钮被点击：挣对于多层次需要传递数据
    
   [[NSNotificationCenter defaultCenter] postNotificationName:SWStatusOriginalDidMoreNotication object:nil];
 
    
}
@end
