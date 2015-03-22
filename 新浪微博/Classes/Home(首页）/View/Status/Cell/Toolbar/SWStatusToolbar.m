//
//  HMStatusToolbar.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWStatusToolbar.h"
@interface SWStatusToolbar()

@property (nonatomic, strong) NSMutableArray *dividers;

@end

@implementation SWStatusToolbar

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.btns enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setBackgroundImage:[UIImage resizableImageWithName:@"common_card_bottom_background"] forState:UIControlStateNormal];
        }];
        [self setupDivider];
        [self setupDivider];

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
   [[UIImage resizableImageWithName:@"common_card_bottom_background"] drawInRect:rect];

}

/**
 *  分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
     int dividerCount = (int)self.dividers.count;
    CGFloat divideFrisrtX = self.width / (dividerCount + 1);
    CGFloat divideH = self.height;
   
    
    // 设置分割线的frame
   
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = divideH;
        divider.centerX = (i + 1) * divideFrisrtX;
        divider.centerY = divideH * 0.5;
    }
}

@end
