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
@interface SWStatusRetweetedView()

/** 正文 */
@property (nonatomic, weak) SWStatusLable *textLabel;
/** 配图相册 */
@property (nonatomic, weak) SWStatusPhotosView *photosView;
@end
@implementation SWStatusRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

        self.image = [UIImage resizableImageWithName:@"timeline_retweet_background"];
        
        // 1.昵称
//        UILabel *nameLabel = [[UILabel alloc] init];
//        nameLabel.textColor = SWColor(80, 120, 170);
//        nameLabel.font = SWStatusRetweetedNameFont;
//        [self addSubview:nameLabel];
//        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        SWStatusLable *textLabel = [[SWStatusLable alloc] init];
        //textLabel.textColor = SWColor(129, 129, 129);
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        // 3.配图相册
        SWStatusPhotosView *photosView = [[SWStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}
- (void)setRetweetedFrame:(SWStatusRetweetedFrame *)retweetedFrame
{
    self.frame = retweetedFrame.frame;
    // 取出微博数据
    SWStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
//    SWUser *user = retweetedStatus.user;
    //1.设置昵称的frame
//    self.nameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
//    self.nameLabel.frame = retweetedFrame.nameFrame;
    //2.设置转发正文的内容和frame
    self.textLabel.attributedText = retweetedStatus.attributedText;
    self.textLabel.frame = retweetedFrame.textFrame;
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) { // 有配图
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.picUrls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
}

@end
