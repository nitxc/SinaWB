//
//  SWStatusRetweetedFrame.m
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//  转发微博frame数据
//

#import "SWStatusRetweetedFrame.h"
#import "SWUser.h"
#import "SWStatus.h"
#import "SWStatusPhotosView.h"
@implementation SWStatusRetweetedFrame
- (void)setRetweetedStatus:(SWStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.昵称
    //    CGFloat nameX = SWStatusCellInset;
    //    CGFloat nameY = SWStatusCellInset * 0.5;
    //    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    //    CGSize nameSize = [name sizeWithFont:SWStatusRetweetedNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 1.正文
    CGFloat textX = SWStatusCellInset;
    CGFloat textY = SWStatusCellInset * 0.5;
    CGFloat maxW = SWScreenWidth - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    // 2.配图相册
    CGFloat h = 0;
    CGFloat toolbarY = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
        CGSize photosSize = [SWStatusPhotosView sizeWithPhotosCount:(int)retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        h = CGRectGetMaxY(self.photosFrame) + SWStatusCellInset;
        
        toolbarY =  CGRectGetMaxY(self.photosFrame) + SWStatusCellInset;
    } else {
        
        h = CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
        toolbarY =  CGRectGetMaxY(self.textFrame) + SWStatusCellInset;
    }
    
    // 3.设置工具条的frame（判断是否需要显示）
    if(retweetedStatus.detailContent){//需要显示工具条
        
        
        CGFloat toolbarW = 200;
        CGFloat toolbarX = SWScreenWidth - toolbarW;
        CGFloat toolbarH = 20;
        self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        h = CGRectGetMaxY(self.toolbarFrame) + SWStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = SWScreenWidth;
    self.frame = CGRectMake(x, y, w, h);
}
@end
