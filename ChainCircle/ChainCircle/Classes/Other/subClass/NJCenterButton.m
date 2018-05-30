//
//  NJCenterButton.m
//  ConsumptionPlus
//
//  Created by TouchWorld on 2017/10/12.
//  Copyright © 2017年 qichen. All rights reserved.
//

#import "NJCenterButton.h"
@interface NJCenterButton ()
/********* 间距 *********/
@property(nonatomic,assign)CGFloat margin;

@end

@implementation NJCenterButton
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)imageName margin:(CGFloat)margin
{
    NJCenterButton * centerButton = [NJCenterButton buttonWithType:UIButtonTypeCustom];
    [centerButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [centerButton setTitle:title forState:UIControlStateNormal];
    centerButton.margin = margin;
    return centerButton;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = 0;
    self.titleLabel.frame = titleFrame;
    
    CGRect imageVFrame = self.imageView.frame;
    imageVFrame.origin.x = self.titleLabel.NJ_MaxX + self.margin;
    self.imageView.frame = imageVFrame;
    
}

@end
