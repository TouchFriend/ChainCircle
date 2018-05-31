//
//  NJInviteRecordHeaderView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/5/31.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteRecordHeaderView.h"
#import "UIView+NJCommon.h"
@interface NJInviteRecordHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *myInviteBtn;
- (IBAction)myInviteBtnClick;

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
    
    [self.myInviteBtn addBorderWidth:1.0 color:[UIColor blackColor] cornerRadius:4.0];
    
}

- (IBAction)myInviteBtnClick {
    if(self.myInviteBlock != nil)
    {
        self.myInviteBlock();
    }
}
@end
