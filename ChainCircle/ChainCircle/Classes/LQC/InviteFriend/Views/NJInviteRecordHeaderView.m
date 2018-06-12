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
@property (weak, nonatomic) IBOutlet UILabel *firstNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondeNumLabel;

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

- (void)setFirstInviteNum:(NSInteger)firstInviteNum
{
    _firstInviteNum = firstInviteNum;
    self.firstNumLabel.text = [NSString stringWithFormat:@"%ld", firstInviteNum];
}

- (void)setSecondeInviteNum:(NSInteger)secondeInviteNum
{
    _secondeInviteNum = secondeInviteNum;
    self.secondeNumLabel.text = [NSString stringWithFormat:@"%ld", secondeInviteNum];
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
    
    CGFloat firstReword = 0;
    CGFloat secondReword = 0;
    for (NJSettingItem * item in settingArr) {
        if([item.name isEqualToString:@"fx_get"])
        {
            firstReword = item.value.integerValue;
        }
        if([item.name isEqualToString:@"fx_father_get"])
        {
            secondReword = item.value.floatValue;
            
        }
    }
    
    NSString * text = [NSString stringWithFormat:@"邀请朋友可以获得二级奖励：\n每邀请一个好友获得%.2lfLQC，好友成功邀请TA的好友你还可以再获得%.2lfLQC", firstReword, secondReword];
    
    NSMutableParagraphStyle * paraStyleM = [[NSMutableParagraphStyle alloc] init];
    paraStyleM.lineSpacing = 4.0;
    NSDictionary * attrDic = @{
                               NSParagraphStyleAttributeName : paraStyleM
                               };
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithString:text attributes:attrDic];
    self.titleLabel.attributedText = attrStr;
}
@end
