//
//  XYSrefreshHeaderView.h
//  Chat
//
//  Created by 徐烨晟 on 16/6/10.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSrefreshHeaderView ;

@protocol XYSrefrshHeaderViewDelegate <NSObject>

@optional
-(void)XYSrefrshHeaderViewDidClick:(XYSrefreshHeaderView*)refreshHeaderView;

@end

@interface XYSrefreshHeaderView : UIView

@property (nonatomic,weak)id<XYSrefrshHeaderViewDelegate> delegate;

+(instancetype)refreshHeader;
-(void)refresh;
-(void)endRefresh;
@end
