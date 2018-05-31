//
//  NJInviteFriendTableHeaderView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteFriendTableHeaderView.h"
@interface NJInviteFriendTableHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIButton *duplicateBtn;
- (IBAction)duplicateBtnClick;

@property (weak, nonatomic) IBOutlet UILabel *totalPersonLabel;

/********* <#注释#> *********/
@property(nonatomic,copy)NSString * totalPersonStr;


@end

@implementation NJInviteFriendTableHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.containerView addAllCornerRadius:8.0];
    
    [self.duplicateBtn addBorderWidth:1.0 color:[UIColor blackColor] cornerRadius:4.0];
    
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
}

- (IBAction)duplicateBtnClick {
}
@end
