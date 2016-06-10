//
//  XYSMessage.h
//  Chat
//
//  Created by 徐烨晟 on 16/6/6.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    XYSMessageTypeMe = 0,
    XYSMessageTypeOthers = 1
}XYSMessageType;

@interface XYSMessage : NSObject

@property (strong,nonatomic)NSString * text;
@property (strong,nonatomic)NSString * time;
@property (assign,nonatomic)XYSMessageType type;

@property (assign,nonatomic)CGFloat cellHeight;
@property (assign,nonatomic) BOOL isTimeHidden;

+(instancetype)messageWithDict:(NSDictionary *)dict;
@end
