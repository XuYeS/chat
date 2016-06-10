//
//  XYSMessageCell.m
//  Chat
//
//  Created by 徐烨晟 on 16/6/6.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSMessageCell.h"
#import "XYSMessage.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
@interface XYSMessageCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *textButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation XYSMessageCell

- (void)awakeFromNib {
    // Initialization code
    self.textButton.titleLabel.numberOfLines = 0;
}
-(void)setMessage:(XYSMessage *)message
{
    _message = message;
    self.timeLabel.text = message.time;
    [self.textButton setTitle:message.text forState:UIControlStateNormal];
    
    [self.textButton layoutIfNeeded];
    
    [self.textButton updateConstraints:^(MASConstraintMaker *make) {//important!!!
        CGFloat LabelH = self.textButton.titleLabel.frame.size.height;
        make.height.equalTo(LabelH+30);
    }];
    if (message.isTimeHidden == YES) {
        self.timeLabel.hidden = YES;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }else{
        self.timeLabel.text = message.time;
        self.timeLabel.hidden = NO;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(30);
        }];
    }
    
    
    [self.textButton layoutIfNeeded];
    
    CGFloat iconViewMaxY = CGRectGetMaxY(self.iconView.frame);
    CGFloat textButtonMaxY = CGRectGetMaxY(self.textButton.frame);
    message.cellHeight  =   MAX(iconViewMaxY, textButtonMaxY)+10;
    
}


@end
