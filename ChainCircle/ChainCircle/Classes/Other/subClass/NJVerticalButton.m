//
//  NJVerticalButton.m
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/26.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import "NJVerticalButton.h"

@interface NJVerticalButton ()
/********* 图片 *********/
@property(nonatomic,weak)UIImageView * iconImageV;
/********* 标题 *********/
@property(nonatomic,weak)UILabel * textLabel;
@end

@implementation NJVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupInit];
    }
    return self;
}
- (void)setupInit
{
    //图片
    UIImageView * iconImageV = [[UIImageView alloc]init];
    self.iconImageV = iconImageV;
    [self addSubview:iconImageV];
    
    //标题
    UILabel * textLabel = [[UILabel alloc]init];
    self.textLabel = textLabel;
    textLabel.font = [UIFont systemFontOfSize:12.0];
    textLabel.textColor = NJGrayColor(107);
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat iconImageVWidth = self.imageWidth > 0 ? self.imageWidth : 45;
    CGFloat iconImageVX = (self.NJ_width - iconImageVWidth) * 0.5;
    self.iconImageV.frame = CGRectMake(iconImageVX, 8, iconImageVWidth, iconImageVWidth);
    self.textLabel.frame = CGRectMake(0, self.iconImageV.NJ_MaxY + 5, self.NJ_width, 12);
}
- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.iconImageV.image = [UIImage imageNamed:imageName];
    
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.textLabel.text = title;
}
@end
