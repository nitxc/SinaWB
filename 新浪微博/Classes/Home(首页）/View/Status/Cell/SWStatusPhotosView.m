//
//  SWStatusPhotosView.m
//  新浪微博
//
//  Created by xc on 15/3/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWStatusPhotosView.h"
#import "SWStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "SWPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#define SWStatusPhotosMaxCount 9
#define SWStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define SWStatusPhotoW SWScreenWidth*0.21
#define SWStatusPhotoH SWStatusPhotoW
#define SWStatusPhotoMargin 5


@interface SWStatusPhotosView()

@property(nonatomic, assign) CGRect lastFrame;
@property(nonatomic,weak) UIImageView *bigImageView;

@end

@implementation SWStatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // 预先创建9个图片控件
        for (int i = 0; i<SWStatusPhotosMaxCount; i++) {
            SWStatusPhotoView *photoView = [[SWStatusPhotoView alloc] init];
            photoView.tag = i;
            
            [self addSubview:photoView];
            //未每一个控件添加一个手势：注意：手势控件只能控制一个
           UITapGestureRecognizer *gestureReccognizer=  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(statusPhotoOnTap:)];
            [photoView addGestureRecognizer:gestureReccognizer];
            
        }
    }
    return self;
}
- (void)statusPhotoOnTap:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    int count = (int)self.picUrls.count;
    for (int i = 0; i<count; i++) {
        SWPhoto *pic = self.picUrls[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 3.显示浏览器
    [browser show];
}


- (void)setPicUrls:(NSArray *)pic_urls
{
    _picUrls = pic_urls;
    
    for (int i = 0; i<SWStatusPhotosMaxCount; i++) {
        SWStatusPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.picUrls.count;
    int maxCols = SWStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        SWStatusPhotoView *photoView = self.subviews[i];
        photoView.width = SWStatusPhotoW;
        photoView.height = SWStatusPhotoH;
        photoView.x = (i % maxCols) * (SWStatusPhotoW + SWStatusPhotoMargin);
        photoView.y = (i / maxCols) * (SWStatusPhotoH + SWStatusPhotoMargin);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    int maxCols = SWStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * SWStatusPhotoW + (totalCols - 1) * SWStatusPhotoMargin;
    CGFloat photosH = totalRows * SWStatusPhotoH + (totalRows - 1) * SWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
