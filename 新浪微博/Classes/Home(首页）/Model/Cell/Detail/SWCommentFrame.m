//
//  SWCommentFrame.m
//  新浪微博
//
//  Created by xc on 15/3/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//  描述评论的frame
//
#import "NSString+Extension.h"
#import "SWCommentFrame.h"
#import "SWUser.h"
#import "SWComment.h"
@implementation SWCommentFrame

- (void)setComment:(SWComment *)comment
{
    _comment = comment;
    
    //1.设置头像的frame
    CGFloat iconX = SWCommentCellInset;
    CGFloat iconY = SWCommentCellInset;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    //2.设置昵称的frame
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + SWCommentCellInset;
    CGFloat nameY = iconY;
    
    CGSize nameSize = [_comment.user.name sizeWithFont:SWCommentUserNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (comment.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + SWCommentCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    //3.时间frame的计算
     CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame)+SWCommentCellInset;
    CGSize timeSize = [_comment.created_at sizeWithFont:SWCommentTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _timeFrame = (CGRect){{timeX,timeY},timeSize};
    //4.设置评论正文的frame
    CGFloat textX = timeX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + SWCommentCellInset;
    CGFloat maxW = SWScreenWidth - textX -SWCommentTextMargin;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [comment.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    //5.计算cell的高度
    
    self.cellHeight = CGRectGetMaxY( self.textFrame) +SWCommentCellInset;
    
}


@end
