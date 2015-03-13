//
//  HMSendStatusParam.h
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWBaseParam.h"
@interface SWSendStatusParam : SWBaseParam


/**	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property (nonatomic, copy) NSString *status;

@end
