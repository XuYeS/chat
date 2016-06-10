//
//  XYSrefreshHeaderView.m
//  Chat
//
//  Created by 徐烨晟 on 16/6/10.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSrefreshHeaderView.h"
@interface XYSrefreshHeaderView()
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@end

@implementation XYSrefreshHeaderView

+(instancetype)refreshHeader
{

    XYSrefreshHeaderView *refrshHeader = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    refrshHeader.loadingView.hidden = YES;
    refrshHeader.refreshButton.hidden = NO;
    return refrshHeader;
}

- (IBAction)refreshTap:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(XYSrefrshHeaderViewDidClick:)]) {
        [self.delegate XYSrefrshHeaderViewDidClick:self];
    }
    
}
-(void)refresh
{
    self.refreshButton.hidden = YES;
    self.loadingView.hidden = NO;
}
-(void)endRefresh
{
    self.refreshButton.hidden = NO;
    self.loadingView.hidden = YES;
}

@end
