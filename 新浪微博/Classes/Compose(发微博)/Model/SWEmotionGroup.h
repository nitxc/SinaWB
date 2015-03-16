//
//  SWEmotionGroup.h
//  新浪微博
//
//  Created by xc on 15/3/13.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWEmotionGroup : NSObject
/** 表情分组身份 */
@property (nonatomic,copy) NSString *emoticon_group_identifier;

/** 表情类型 */
@property (nonatomic,copy) NSString *emoticon_group_type;

/**  */
@property (nonatomic, strong) NSArray *emoticon_group_emoticons;


@end
