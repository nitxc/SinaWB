//
//  MJReshActivityIndicatorView.m
//  新浪微博
//
//  Created by xc on 15/3/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "MJReshActivityIndicatorView.h"

@interface MJReshActivityIndicatorView()

@property(nonatomic, weak) UIImageView *imageActivityView;

@end

@implementation MJReshActivityIndicatorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *imageActivityView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_loading"]];
        self.hidden = YES;
        [self addSubview:imageActivityView];
        _imageActivityView = imageActivityView;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
  
    _imageActivityView.frame = CGRectMake(0, 2, 25, 25);
    
}
- (void)startAnimating
{
    self.hidden = NO;
    [UIView animateWithDuration:1.0 animations:^{
         _imageActivityView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
   
}
- (void)stopAnimating
{
    _imageActivityView.transform = CGAffineTransformIdentity;
    self.hidden = YES;

}
@end
