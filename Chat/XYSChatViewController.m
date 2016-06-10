//
//  XYSChatViewController.m
//  Chat
//
//  Created by 徐烨晟 on 16/6/6.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSChatViewController.h"
#import "XYSMessageCell.h"
#import "XYSMessage.h"
#import "XYSrefreshHeaderView.h"
@interface XYSChatViewController ()<UITableViewDataSource,UITableViewDelegate,XYSrefrshHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *messages;//每一个都是XYSMessage
@end

@implementation XYSChatViewController
#pragma mark - 懒加载
-(NSMutableArray *)messages
{
    if (!_messages) {
        _messages = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];//现在每个都是dict
        
        NSMutableArray *messageArray = [NSMutableArray array];
         XYSMessage *lastMessage = [[XYSMessage alloc]init];
        for (NSDictionary *dict in dictArray) {
            XYSMessage *oneMessage = [XYSMessage messageWithDict:dict];
            oneMessage.isTimeHidden = [oneMessage.time isEqualToString:lastMessage.time];
            [messageArray addObject:oneMessage];
            lastMessage = oneMessage;
        }
        _messages =messageArray;
    }
    return _messages;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(translationView:) name:UIKeyboardDidChangeFrameNotification object:nil];
    XYSrefreshHeaderView *refreshHeaderView = [XYSrefreshHeaderView refreshHeader];
    refreshHeaderView.delegate = self;
    self.tableView.tableHeaderView =refreshHeaderView;
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - keyboard
-(void)translationView:(NSNotification*)note
{
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGFloat transformY = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        self.view.transform = CGAffineTransformMakeTranslation(0, -transformY);
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - XYSrefrshHeaderViewDelegate
-(void)XYSrefrshHeaderViewDidClick:(XYSrefreshHeaderView *)refreshHeaderView
{
    XYSrefreshHeaderView *headerView =(XYSrefreshHeaderView *) self.tableView.tableHeaderView;
    [headerView refresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [headerView endRefresh];
    });
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSMessage *message = self.messages[indexPath.row];
    NSString* Type = message.type==XYSMessageTypeMe? @"messageCellMe":@"messageCellOthers";
    XYSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:Type];
    cell.message = self.messages[indexPath.row];
    
    return cell;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSMessage *message = self.messages[indexPath.row];
    return message.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
