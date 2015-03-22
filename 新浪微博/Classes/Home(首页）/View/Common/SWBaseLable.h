//
//  SWBaseLable.h
//  新浪微博
//
//  Created by xc on 15/3/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SWBaseLableEventNoticationTypeComment,
    SWBaseLableEventNoticationTypeStatus
    
} SWBaseLableEventNoticationType;
@interface SWBaseLable : UIView
/** 展示微博富文本内容 */
@property (nonatomic, strong) NSAttributedString *attributedText;

@property (nonatomic, assign) SWBaseLableEventNoticationType noticationType;

@end
