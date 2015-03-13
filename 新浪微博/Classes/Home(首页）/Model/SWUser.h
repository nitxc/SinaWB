//
//  SWUser.h
//  新浪微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface SWUser : NSObject
/** string 	友好显示名称 */
@property (nonatomic, copy) NSString *name;

/** string 	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
/** 会员类型 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;
/** 性别 */
@property (nonatomic, copy) NSString *gender;

@property (nonatomic, assign, getter = isVip, readonly) BOOL vip;

/** 是否是微博认证用户，即加V用户，true：是，false：否 */
@property (nonatomic,copy) NSString *verified;
/** 是否是微博认证用户类型*/
@property (nonatomic,assign) int verified_type;
@end
