//
//  SWStatusDetailTopToolbar.h
//  新浪微博
//
//  Created by xc on 15/3/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SWStatusDetailTopToolbarButtonTypeRetweeted,
    SWStatusDetailTopToolbarButtonTypeComment,
} SWStatusDetailTopToolbarButtonType;

@class SWStatusDetailTopToolbar, SWStatus;

@protocol SWStatusDetailTopToolbarDelegate <NSObject>

@optional
- (void)topToolbar:(SWStatusDetailTopToolbar *)topToolbar didSelectedButton:(SWStatusDetailTopToolbarButtonType)buttonType;
@end

@interface SWStatusDetailTopToolbar : UIView
+ (instancetype)toolbar;

@property (nonatomic, weak) id<SWStatusDetailTopToolbarDelegate> delegate;
@property (nonatomic, assign) SWStatus *status;

@property (nonatomic, assign) SWStatusDetailTopToolbarButtonType selectedButtonType;

@end
