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
    
    
    
    
    self.totalPersonStr = @"当前已有 20110601 人加入链圈社群";
    
    NSMutableAttributedString * attrStrM = [[NSMutableAttributedString alloc] initWithString:self.totalPersonStr attributes:@{
                                                                                                                              NSFontAttributeName : [UIFont systemFontOfSize:16.0],
                                                                                                                              NSForegroundColorAttributeName : [UIColor blackColor],
                                                                                                                              }];
    NSRange range = [self.totalPersonStr rangeOfString:@"20110601" options:kNilOptions];
    
    NSDictionary * attrDic = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:25.0 weight:UIFontWeightBold],
                               NSForegroundColorAttributeName : [UIColor blackColor],
                               };
    
    [attrStrM addAttributes:attrDic range:range];
    
    self.totalPersonLabel.attributedText = attrStrM;
    
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

@end
