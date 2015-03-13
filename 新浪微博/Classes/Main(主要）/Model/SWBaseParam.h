//
//  SWBaseParam.h
//  新浪微博
//
//  Created by xc on 15/3/10.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWBaseParam : NSObject
/**	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。*/
@property (nonatomic, copy) NSString *access_token;

+(instancetype)param;
@end
