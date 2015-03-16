//
//  SWStatusOrginal.m
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//  原创微博
//

#import "SWStatusOriginalFrame.h"
#import "SWStatus.h"
#import "SWUser.h"
#import "SWStatusPhotosView.h"
@implementation SWStatusOriginalFrame
- (void)setStatus:(SWStatus *)status
{
    _status = status;
    
    // 1.头像
    CGFloat iconX = SWStatusCellInset;
    CGFloat iconY = SWStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
      // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + SWStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:SWStatusOriginalNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + SWStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + SWStatusCellInset;
    CGFloat maxW = SWScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 4.更多图标计算
    UIImage *moreImage = [UIImage imageNamed:@"timeline_icon_more"];
    CGFloat moreW = moreImage.size.width;

    CGFloat moreX = SWScreenWidth-SWStatusCellInset - moreW;
    CGFloat moreY = iconY;
    CGFloat moreH = moreImage.size.height;
    self.moreFrame = CGRectMake(moreX, moreY, moreW, moreH);
    
    // 5.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
        CGSize photosSize = [SWStatusPhotosView sizeWithPhotosCount:(int)status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + SWStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SWScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
    
}
@end
