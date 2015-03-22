//
//  SWStatusUserHeadView.m
//  新浪微博
//
//  Created by xc on 15/3/11.
//  Copyright (c) 2015年 xc. All rights reserved.
//  自定义用户头像
//

#import "SWStatusUserHeadView.h"

@interface SWStatusUserHeadView()
@property(nonatomic,weak)UIImageView * veritfiedImageView;

@end
@implementation SWStatusUserHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *veritfiedImageView=[[UIImageView alloc]init];
        
        [self addSubview:veritfiedImageView];
        _veritfiedImageView = veritfiedImageView;
        //设置头像显示模式
        //self.contentMode = UIViewContentModeScaleTo;
        
    }
    
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIImage *vipImage = [UIImage imageNamed:@"avatar_vip"];;
    
    _veritfiedImageView.center = CGPointMake(self.width, self.height);
    _veritfiedImageView.width = vipImage.size.width-1;
    _veritfiedImageView.height = vipImage.size.height-1;
    
}

/**
 *  添加V子验证图片
 *
 *  @param verified     1：验证 0：为验证
 *  @param verifiedType 验证类型：0 个人 3 企业
 */
- (void)addVIPImageWithVeritfied:(NSString *)verified verifiedType:(int)verifiedType
{
 
    UIImage *vipImage;
    _veritfiedImageView.hidden = YES;
    if (verified.intValue == 0)return;
     _veritfiedImageView.hidden = NO;
    if (verifiedType == 0) {//个人认证
        vipImage = [UIImage imageNamed:@"avatar_vip"];
        
    }
    if (verifiedType == 3) {//企业认证
        vipImage = [UIImage imageNamed:@"avatar_enterprise_vip"];
    }
   _veritfiedImageView.image = vipImage;
    
}


@end
