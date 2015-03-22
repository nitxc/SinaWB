//
//  HMStatusRetweetedView.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWStatusRetweetedView.h"
#import "SWStatusRetweetedFrame.h"
#import "SWStatus.h"
#import "SWStatusPhotosView.h"
#import "SWStatusLable.h"
#import "SWStatusRetweetedToolBar.h"
@interface SWStatusRetweetedView()

/** 正文 */
@property (nonatomic, weak) SWStatusLable *textLabel;
/** 配图相册 */
@property (nonatomic, weak) SWStatusPhotosView *photosView;
/** 转发微博工具条*/

@property (nonatomic, weak) SWStatusRetweetedToolbar *toolbar;
@end
@implementation SWStatusRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

        self.image = [UIImage resizableImageWithName:@"timeline_retweet_background"];
        
        
        // 1.正文（内容）
        SWStatusLable *textLabel = [[SWStatusLable alloc] init];
        //textLabel.textColor = SWColor(129, 129, 129);
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        // 2.配图相册
        SWStatusPhotosView *photosView = [[SWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        // 3.设置微博正文工具条
        SWStatusRetweetedToolbar *toolbar = [[SWStatusRetweetedToolbar alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        
    
    }
    return self;
}
- (void)setRetweetedFrame:(SWStatusRetweetedFrame *)retweetedFrame
{
    self.frame = retweetedFrame.frame;
    // 取出微博数据
    SWStatus *retweetedStatus = retweetedFrame.retweetedStatus;

    //1.设置转发正文的内容和frame
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.frame = retweetedFrame.textFrame;
    //2.配图相册
    if (retweetedStatus.pic_urls.count) { // 有配图
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.picUrls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    //3.设置工具条
    if (retweetedStatus.detailContent) {
        self.toolbar.frame = retweetedFrame.toolbarFrame;
        self.toolbar.hidden = NO;
        self.toolbar.status = retweetedStatus;
    }else{
        self.toolbar.hidden = YES;
    }
}

@end
