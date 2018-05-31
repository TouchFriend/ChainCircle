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

@end
@implementation NJInviteRecordHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CAShapeLayer * circleCornerLayer = [CAShapeLayer layer];
    circleCornerLayer.frame = CGRectMake(0, 0, NJScreenW - 30, 161);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:circleCornerLayer.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)];
    circleCornerLayer.fillColor = [UIColor whiteColor].CGColor;
    circleCornerLayer.path = path.CGPath;
    
    [self.contentView.layer addSublayer:circleCornerLayer];
    
}

@end
