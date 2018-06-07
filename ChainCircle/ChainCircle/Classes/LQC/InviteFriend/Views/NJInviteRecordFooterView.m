//
//  NJInviteRecordFooterView.m
//  ChainCircle
//
//  Created by TouchWorld on 2018/6/7.
//  Copyright © 2018年 Redirect. All rights reserved.
//

#import "NJInviteRecordFooterView.h"

@implementation NJInviteRecordFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        [self setupInit];
    }
    return self;
}

- (void)setupInit
{
    self.backgroundColor = [UIColor clearColor];

    CAShapeLayer * circleCornerLayer = [CAShapeLayer layer];

    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, NJScreenW - 30, 38) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8.0, 8.0)];

    circleCornerLayer.path = path.CGPath;

    circleCornerLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:circleCornerLayer];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 15;
    frame.size.width -= 30;
    [super setFrame:frame];
}
@end
