//
//  NJInviteCodeVC.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteCodeVC.h"
#import "NJUserItem.h"

@interface NJInviteCodeVC ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIButton *duplicateBtn;
- (IBAction)duplicateBtnClick;

@property (weak, nonatomic) IBOutlet UILabel *totalPersonLabel;

/********* <#注释#> *********/
@property(nonatomic,copy)NSString * totalPersonStr;
@property (weak, nonatomic) IBOutlet UILabel *inviteCodeLabel;

@end

@implementation NJInviteCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupInit];
}

#pragma mark - 设置初始化
- (void)setupInit
{
    self.invitedNum = 0;
    
    [self.containerView addAllCornerRadius:8.0];
    
    [self.duplicateBtn addBorderWidth:1.0 color:[UIColor blackColor] cornerRadius:4.0];
    
    self.totalPersonStr = [NSString stringWithFormat:@"当前已有 %ld 人加入链圈社群", self.invitedNum];
    
    NSMutableAttributedString * attrStrM = [[NSMutableAttributedString alloc] initWithString:self.totalPersonStr attributes:@{
                                                                                                                              NSFontAttributeName : [UIFont systemFontOfSize:16.0],
                                                                                                                              NSForegroundColorAttributeName : [UIColor blackColor],
                                                                                                                              }];
    NSRange range = [self.totalPersonStr rangeOfString:[NSString stringWithFormat:@"%ld", self.invitedNum] options:kNilOptions];
    
    NSDictionary * attrDic = @{
                               NSFontAttributeName : [UIFont systemFontOfSize:25.0 weight:UIFontWeightBold],
                               NSForegroundColorAttributeName : [UIColor blackColor],
                               };
    
    [attrStrM addAttributes:attrDic range:range];
    
    self.totalPersonLabel.attributedText = attrStrM;
    
    NJUserItem * userItem = [NJLoginTool getCurrentUser];
    
    self.inviteCodeLabel.text = userItem.invite_code;
}

- (IBAction)duplicateBtnClick {
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.inviteCodeLabel.text;
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    [SVProgressHUD dismissWithDelay:1.2];
}

@end
