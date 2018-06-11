//
//  NJInviteRecordHeaderView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteRecordHeaderView.h"
#import "UIView+NJCommon.h"
#import "NJSettingItem.h"

@interface NJInviteRecordHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *myInviteBtn;
- (IBAction)myInviteBtnClick;
@property (weak, nonatomic) IBOutlet UILabel *inviteNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation NJInviteRecordHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CAShapeLayer * circleCornerLayer = [CAShapeLayer layer];
    circleCornerLayer.frame = CGRectMake(0, 0, NJScreenW - 30, 191);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:circleCornerLayer.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)];
    circleCornerLayer.fillColor = [UIColor whiteColor].CGColor;
    circleCornerLayer.path = path.CGPath;
    
    [self.contentView.layer addSublayer:circleCornerLayer];
    
    [self.myInviteBtn addAllCornerRadius:4.0];
    
    
    
}

- (void)setInvitedNum:(NSInteger)invitedNum
{
    _invitedNum = invitedNum;
    
    self.inviteNumLabel.text = [NSString stringWithFormat:@"%ld", invitedNum];
}

- (IBAction)myInviteBtnClick {
    if(self.myInviteBlock != nil)
    {
        self.myInviteBlock();
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 15;
    frame.size.width -= 30;
    [super setFrame:frame];
}

- (void)setSettingArr:(NSArray<NJSettingItem *> *)settingArr
{
    _settingArr = settingArr;
    if(settingArr.count == 0)
    {
        return;
    }
    
    CGFloat bandFriendNum = 0;
    CGFloat scale = 0;
    CGFloat bandHisFriendNum = 0;
    for (NJSettingItem * item in settingArr) {
        if([item.name isEqualToString:@"band_lqc_user"])
        {
            bandFriendNum = item.value.integerValue;
        }
        if([item.name isEqualToString:@"fx_get"])
        {
            scale = item.value.floatValue;
            
        }
    }
    bandHisFriendNum = scale;
    
    NSString * text = [NSString stringWithFormat:@"邀请朋友可以获得二级奖励：\n每邀请一个好友获得%.2lfLQC，好友成功邀请TA的好友你还可以再获得%.2lfLQC", bandFriendNum, bandHisFriendNum];
    
    NSMutableParagraphStyle * paraStyleM = [[NSMutableParagraphStyle alloc] init];
    paraStyleM.lineSpacing = 4.0;
    NSDictionary * attrDic = @{
                               NSParagraphStyleAttributeName : paraStyleM
                               };
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:text attributes:attrDic];
    self.titleLabel.attributedText = attrStr;
}
@end
