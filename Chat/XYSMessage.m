//
//  XYSMessage.m
//  Chat
//
//  Created by 徐烨晟 on 16/6/6.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSMessage.h"


@implementation XYSMessage
+(instancetype)messageWithDict:(NSDictionary *)dict
{
    XYSMessage *message = [[self alloc]init];
    [message setValuesForKeysWithDictionary:dict];
    return message;
}
@end
