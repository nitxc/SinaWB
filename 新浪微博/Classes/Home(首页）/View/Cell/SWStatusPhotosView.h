//
//  SWStatusPhotosView.h
//  新浪微博
//
//  Created by xc on 15/3/12.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWStatusPhotosView : UIImageView
/**
 *  图片数据（里面都是HMPhoto模型）
 */
@property (nonatomic, strong) NSArray *picUrls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;
@end
