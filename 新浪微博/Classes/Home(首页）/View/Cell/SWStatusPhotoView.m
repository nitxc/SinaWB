//
//  SWStatusPhotoView.m
//  新浪微博
//
//  Created by xc on 15/3/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWStatusPhotoView.h"
#import "SWPhoto.h"
#import "UIImageView+WebCache.h"
@interface SWStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation SWStatusPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
     
    }
    return self;
}

- (void)setPhoto:(SWPhoto *)photo
{
    _photo = photo;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
    // 2.控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
  
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
