//
//  SWSearchBar.m
//  新浪微博
//
//  Created by xc on 15/3/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWSearchBar.h"

@implementation SWSearchBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.borderStyle = UITextBorderStyleNone;
        [self setBackground:[UIImage resizableImageWithName:@"search_navigationbar_textfield_background"]];
        [self setFont:[UIFont systemFontOfSize:12]];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageWithName:@"searchbar_textfield_search_icon"];
        imageView.width = imageView.image.size.width+10;
        imageView.height = imageView.image.size.width;
        // 设置leftView的内容居中
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        // 设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置右边永远显示清除按钮
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        
        [clearBtn setImage:[UIImage imageWithName:@"searchbar_textfield_clear_icon" ] forState:UIControlStateNormal];
         [clearBtn setImage:[UIImage imageWithName:@"searchbar_textfield_clear_icon_highlighted" ] forState:UIControlStateHighlighted];
        clearBtn.width = clearBtn.imageView.image.size.width;
        clearBtn.height = clearBtn.imageView.image.size.height;
        self.rightView = clearBtn;
        self.rightViewMode = UITextFieldViewModeWhileEditing;
        //为clearbtn增加删除操作
        [clearBtn addTarget:self action:@selector(deleteSearchContent) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return self;
}

- (void)deleteSearchContent
{
    self.text = nil;
}

+ (instancetype)searchBar
{
    return [[SWSearchBar alloc] init];
}

@end
