//
//  HMNewfeatureViewController.m
//  黑马微博
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//
/**
 图片的加载：
 [UIImage imageNamed:@"home"];  加载png图片

 一、非retina屏幕
 1、3.5 inch（320 x 480）
 * home.png
 
 二、retina屏幕
 1、3.5 inch（640 x 960）
 * home@2x.png
 
 2、4.0 inch（640 x 1136）
 * home-568h@2x.png（如果home是程序的启动图片，才支持自动加载）
 
 三、举例（以下情况都是系统自动加载）
 1、home是启动图片
 * iPhone 1\3G\3GS -- 3.5 inch 非retina ：home.png
 * iPhone 4\4S -- 3.5 inch retina ：home@2x.png
 * iPhone 5\5S\5C -- 4.0 inch retina ：home-568h@2x.png
 
 2、home不是启动图片
 * iPhone 1\3G\3GS -- 3.5 inch 非retina ：home.png
 * iPhone 4\4S -- 3.5 inch retina ：home@2x.png
 * iPhone 5\5S\5C -- 4.0 inch retina ：home@2x.png
 
 3、总结
 * home.png ：3.5 inch 非retina
 * home@2x.png ：retina
 * home-568h@2x.png ：4.0 inch retina + 启动图片
 */

/**
 创建了一个控件，就是看不见
 1.当前控件没有添加到父控件中
 2.当前控件的hidden = YES
 3.当前控件的alpha <= 0.01
 4.没有设置尺寸（frame.size、bounds.size）
 5.位置不对（当前控件显示到窗口以外的区域）
 6.背景色是clearColor
 7.当前控件被其他可见的控件挡住了
 8.当前控件是个显示图片的控件（没有设置图片\图片不存在，比如UIImageView）
 9.当前控件是个显示文字的控件（没有设置文字\文字颜色跟后面的背景色一样，比如UILabel、UIButton）
 10.检查父控件的前9种情况
 
 一个控件能看见，但是点击后没有任何反应：
 1.当前控件的userInteractionEnabled = NO
 2.当前控件的enabled = NO
 3.当前控件不在父控件的边框范围内
 4.当前控件被一个背景色是clearColor的控件挡住了
 5.检查父控件的前4种情况
 6.。。。。。。
 
 文本输入框没有在主窗口上：文本输入框的文字无法输入
 */

#define SWNewfeatureImageCount 2

#import "SWNewfeatureViewController.h"
#import "SWTabBarController.h"

@interface SWNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation SWNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIControl *c;
//    c.enabled
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i<SWNewfeatureImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature%d", i + 1];
        if (SWFourInch) { // 4inch  需要手动去加载4inch对应的-568h图片
            name = [name stringByAppendingString:@"_h"];
        }
        imageView.image = [UIImage imageWithName:name];
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        // 给最后一个imageView添加按钮
        if (i == SWNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(SWNewfeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = SWColor(246, 246, 246);
//    [scrollView.subviews lastObject];
}

/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = SWNewfeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 30;
    [self.view addSubview:pageControl];

    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = SWColor(253, 98, 42); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = SWColor(189, 189, 189); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
}

/**
 设置最后一个UIImageView中的内容
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];
    
    // 2.添加分享按钮
    [self setupShareButton:imageView];
}

/**
 *  添加分享按钮
 */
- (void)setupShareButton:(UIImageView *)imageView
{
    // 1.添加分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
//    shareButton.backgroundColor = [UIColor redColor];
//    shareButton.titleLabel.backgroundColor = [UIColor blueColor];
    [imageView addSubview:shareButton];
    
    // 2.设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.74;
    
    // 4.设置间距
    // top left bottom right
    // 内边距 == 自切
    // 被切掉的区域就不能显示内容了
    // contentEdgeInsets : 切掉按钮内部的内容
//    shareButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    // imageEdgeInsets : 切掉按钮内部UIImageView的内容
//    shareButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    // titleEdgeInsets : 切掉按钮内部UILabel的内容
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

/**
 分享
 */
- (void)share:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.isSelected;
//    UIImage *falseImage = [UIImage imageWithName:@"new_feature_share_false"];
//    if (shareButton.currentImage == falseImage) {
//        [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateNormal];
//    } else {
//        [shareButton setImage:falseImage forState:UIControlStateNormal];
//    }
}

/**
 *  添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    
    // 2.设置背景图片
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置frame
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height * 0.8;
    
    // 4.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  开始微博
 */
- (void)start
{
    // 显示主控制器（HMTabBarController）
    SWTabBarController *vc = [[SWTabBarController alloc] init];
    
    // 切换控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
// push : [self.navigationController pushViewController:vc animated:NO];
// modal : [self presentViewController:vc animated:NO completion:nil];
// window.rootViewController : window.rootViewController = vc;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
}


@end
