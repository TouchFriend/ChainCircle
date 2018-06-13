//
//  NJInviteCardView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/5.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteCardView.h"
#import "NJUserItem.h"

@interface NJInviteCardView ()
@property (weak, nonatomic) IBOutlet UILabel *inviteCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPersonLabel;

/********* <#注释#> *********/
@property(nonatomic,copy)NSString * totalPersonStr;
@property (weak, nonatomic) IBOutlet UILabel *inviteTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inviteCodeImageTopConstraint;

@end

@implementation NJInviteCardView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _invitedNum = 0;
    
    [self setTotalPersonLabel];
    
    if([NJLoginTool isLogin])
    {
        NJUserItem * userItem = [NJLoginTool getCurrentUser];
        
        self.inviteCodeLabel.text = userItem.invite_code;
    }
    else
    {
        self.inviteTitleLabel.hidden = YES;
        self.inviteCodeLabel.hidden = YES;
        self.inviteCodeImageTopConstraint.constant = 0;
    }
    
}

- (void)setTotalPersonLabel
{
    self.totalPersonStr = [NSString stringWithFormat:@"当前已有 %ld 人加入链圈社群", self.invitedNum];
    
    NSMutableAttributedString * attrStrM = [[NSMutableAttributedString alloc] initWithString:self.totalPersonStr attributes:@{
                                                                                                                              NSFontAttributeName : [UIFont systemFontOfSize:16.0],
                                                                                                                              NSForegroundColorAttributeName : [UIColor blackColor],
                                                                                                                              }];
    NSRange range = [self.totalPersonStr rangeOfString:[NSString stringWithFormat:@"%ld", self.invitedNum] options:kNilOptions];
    
    NSDictionary * attrDic = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:25.0 weight:UIFontWeightBold],
                               NSForegroundColorAttributeName : NJOrangeColor,
                               };
    
    [attrStrM addAttributes:attrDic range:range];
    
    self.totalPersonLabel.attributedText = attrStrM;
    
}

- (void)setInvitedNum:(NSInteger)invitedNum
{
    _invitedNum = invitedNum;
    
    [self setTotalPersonLabel];
}

@end
