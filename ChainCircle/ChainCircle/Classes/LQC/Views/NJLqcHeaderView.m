//
//  NJLqcHeaderView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJLqcHeaderView.h"
#import "NJUserItem.h"

@interface NJLqcHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *myLqcNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *myRedBagLabel;


@property (weak, nonatomic) IBOutlet UIButton *receiveBtn;
- (IBAction)receiveBtnClick;

@end
@implementation NJLqcHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.receiveBtn addAllCornerRadius:4.0];
    
    [self setPersonalInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:NotificationLoginSuccess object:nil];
    
    
}

- (void)setPersonalInfo
{
    if(![NJLoginTool isLogin])
    {
        return;
    }
    
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    
    self.myLqcNumLabel.text = userItem.lqc_num;
    
    self.myRedBagLabel.text = [NSString stringWithFormat:@"我的红包：%@", userItem.red_num.stringValue];
    
    self.canReceiveNumLabel.text = userItem.total_get.stringValue;
}

#pragma mark - 事件 && 通知
- (IBAction)receiveBtnClick {
    if(self.receiveBlock != nil)
    {
        self.receiveBlock();
    }
}

- (void)loginSuccess
{
    [self setPersonalInfo];
}
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
